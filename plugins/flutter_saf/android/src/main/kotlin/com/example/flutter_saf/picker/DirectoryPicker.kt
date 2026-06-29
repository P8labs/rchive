package com.example.flutter_saf.picker

import android.app.Activity
import android.content.Intent
import android.net.Uri
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

class DirectoryPicker : PluginRegistry.ActivityResultListener {
    private var activity: Activity? = null
    private var pendingResult: MethodChannel.Result? = null

    fun setActivity(activity: Activity?) {
        this.activity = activity
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode != 1001) {
            return false
        }

        val result = pendingResult
        pendingResult = null

        if (result == null) {
            return true
        }

        if (resultCode != Activity.RESULT_OK) {
            result.success(null)
            return true
        }

        val uri = data?.data
        if (uri == null) {
            result.success(null)
            return true
        }

        persistPermission(uri)
        result.success(uri.toString())
        return true
    }

    fun pick(result: MethodChannel.Result) {
        val activity = this.activity
        if (activity == null) {
            result.error("NO_ACTIVITY", "Activity is not attached", null)
            return
        }

        pendingResult = result

        val intent = Intent(Intent.ACTION_OPEN_DOCUMENT_TREE).apply {
            addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            addFlags(Intent.FLAG_GRANT_WRITE_URI_PERMISSION)
            addFlags(Intent.FLAG_GRANT_PERSISTABLE_URI_PERMISSION)
            addFlags(Intent.FLAG_GRANT_PREFIX_URI_PERMISSION)
        }

        activity.startActivityForResult(intent, 1001)
    }

    private fun persistPermission(uri: Uri) {
        val flags =
            Intent.FLAG_GRANT_READ_URI_PERMISSION or
            Intent.FLAG_GRANT_WRITE_URI_PERMISSION

        activity?.contentResolver?.takePersistableUriPermission(
            uri,
            flags,
        )
    }
}
