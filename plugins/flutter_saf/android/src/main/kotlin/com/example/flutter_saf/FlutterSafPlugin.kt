package com.example.flutter_saf

import androidx.annotation.NonNull
import com.example.flutter_saf.picker.DirectoryPicker
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel

class FlutterSafPlugin : FlutterPlugin, ActivityAware {

    private lateinit var channel: MethodChannel
    private val directoryPicker = DirectoryPicker()
    private var handler: FlutterSafMethodCallHandler? = null

    override fun onAttachedToEngine(
        @NonNull binding: FlutterPlugin.FlutterPluginBinding,
    ) {
        channel = MethodChannel(
            binding.binaryMessenger,
            "dev.priyanshu/flutter_saf",
        )
    }

    override fun onDetachedFromEngine(
        @NonNull binding: FlutterPlugin.FlutterPluginBinding,
    ) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(
        binding: ActivityPluginBinding,
    ) {
        directoryPicker.setActivity(binding.activity)
        binding.addActivityResultListener(directoryPicker)

        handler = FlutterSafMethodCallHandler(
            binding.activity,
            directoryPicker,
        )

        channel.setMethodCallHandler(handler)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    override fun onReattachedToActivityForConfigChanges(
        binding: ActivityPluginBinding,
    ) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivity() {
        channel.setMethodCallHandler(null)
        directoryPicker.setActivity(null)
        handler = null
    }
}
