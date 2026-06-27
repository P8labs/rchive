package com.example.flutter_saf

import android.app.Activity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel

class FlutterSafPlugin : FlutterPlugin, ActivityAware {

    private lateinit var channel: MethodChannel

    private var activity: Activity? = null
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
        activity = binding.activity

        handler = FlutterSafMethodCallHandler(
            binding.activity,
        )

        channel.setMethodCallHandler(handler)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        channel.setMethodCallHandler(null)
        handler = null
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(
        binding: ActivityPluginBinding,
    ) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivity() {
        channel.setMethodCallHandler(null)
        handler = null
        activity = null
    }
}