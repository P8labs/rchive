package com.example.flutter_saf

import android.app.Activity
import android.net.Uri
import com.example.flutter_saf.document.DocumentService
import com.example.flutter_saf.exception.SafException
import com.example.flutter_saf.picker.DirectoryPicker
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class FlutterSafMethodCallHandler(
    private val activity: Activity,
    private val directoryPicker: DirectoryPicker,
) : MethodChannel.MethodCallHandler {

    override fun onMethodCall(
        call: MethodCall,
        result: MethodChannel.Result,
    ) {
        try {
            when (call.method) {
                "pickDirectory" -> {
                    directoryPicker.pick(result)
                }

                "exists" -> {
                    val service = service(call)
                    val path = call.argument<String>("path")!!

                    result.success(service.exists(path))
                }

                "list" -> {
                    val service = service(call)
                    val path = call.argument<String>("path")!!

                    result.success(
                        service.list(path).map {
                            mapOf(
                                "name" to it.name,
                                "path" to it.path,
                                "type" to it.type.name.lowercase(),
                                "size" to it.size,
                                "lastModified" to it.lastModified,
                            )
                        },
                    )
                }

                "read" -> {
                    val service = service(call)
                    val path = call.argument<String>("path")!!

                    result.success(
                        service.read(path),
                    )
                }

                "write" -> {
                    val service = service(call)

                    val path = call.argument<String>("path")!!
                    val bytes = call.argument<ByteArray>("bytes")!!

                    service.write(path, bytes)

                    result.success(null)
                }

                "createDirectory" -> {
                    val service = service(call)
                    val path = call.argument<String>("path")!!

                    service.createDirectory(path)
                    val uri = service.createDirectory(path)

                    result.success(uri)
                }

                "delete" -> {
                    val service = service(call)

                    val path = call.argument<String>("path")!!
                    val recursive =
                        call.argument<Boolean>("recursive") ?: false

                    service.delete(path, recursive)

                    result.success(null)
                }

                "rename" -> {
                    val service = service(call)

                    val path = call.argument<String>("path")!!
                    val newName = call.argument<String>("newName")!!

                    service.rename(path, newName)

                    result.success(null)
                }

                else -> result.notImplemented()
            }
        } catch (e: SafException) {
            result.error(
                e.code,
                e.message,
                null,
            )
        } catch (e: Exception) {
            result.error(
                "UNKNOWN_ERROR",
                e.message,
                null,
            )
        }
    }

    private fun service(call: MethodCall): DocumentService {
        val treeUri = Uri.parse(
            call.argument<String>("treeUri")!!,
        )

        return DocumentService(
            context = activity,
            treeUri = treeUri,
        )
    }
}