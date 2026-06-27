package com.example.flutter_saf.picker

import android.app.Activity
import android.content.Intent
import android.net.Uri
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import io.flutter.plugin.common.MethodChannel

class DirectoryPicker(
    private val activity: Activity,
) {
    private var pendingResult: MethodChannel.Result? = null

    private val launcher: ActivityResultLauncher<Intent> =
        activity.registerForActivityResult(
            ActivityResultContracts.StartActivityForResult(),
        ) { result ->
            val callback = pendingResult ?: return@registerForActivityResult
            pendingResult = null

            if (result.resultCode != Activity.RESULT_OK) {
                callback.success(null)
                return@registerForActivityResult
            }

            val uri = result.data?.data

            if (uri == null) {
                callback.success(null)
                return@registerForActivityResult
            }

            persistPermission(uri)

            callback.success(uri.toString())
        }

    fun pick(result: MethodChannel.Result) {
        pendingResult = result

        val intent = Intent(Intent.ACTION_OPEN_DOCUMENT_TREE).apply {
            addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            addFlags(Intent.FLAG_GRANT_WRITE_URI_PERMISSION)
            addFlags(Intent.FLAG_GRANT_PERSISTABLE_URI_PERMISSION)
            addFlags(Intent.FLAG_GRANT_PREFIX_URI_PERMISSION)
        }

        launcher.launch(intent)
    }

    private fun persistPermission(uri: Uri) {
        val flags =
            Intent.FLAG_GRANT_READ_URI_PERMISSION or
            Intent.FLAG_GRANT_WRITE_URI_PERMISSION

        activity.contentResolver.takePersistableUriPermission(
            uri,
            flags,
        )
    }
}