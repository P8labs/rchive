package com.example.flutter_saf.document

import android.content.Context
import android.net.Uri
import android.provider.DocumentsContract
import android.util.Log
import androidx.documentfile.provider.DocumentFile
import com.example.flutter_saf.exception.SafException
import com.example.flutter_saf.util.MimeTypes

class DocumentNavigator(
    context: Context,
    treeUri: Uri,
) {

    private val root: DocumentFile = run {
        val documentUri = DocumentsContract.buildDocumentUriUsingTree(
            treeUri,
            DocumentsContract.getTreeDocumentId(treeUri),
        )

        DocumentFile.fromTreeUri(context, documentUri)
            ?: throw SafException.InvalidTreeUri(treeUri.toString())
    }


    fun resolve(path: String): DocumentFile? {
        if (path.isBlank()) {
            return root
        }

        var current = root

        for (segment in segments(path)) {
            current = current.findFile(segment) ?: return null
        }

        return current
    }

    fun ensureDirectory(path: String): DocumentFile {
        if (path.isBlank()) {
            return root
        }

        var current = root

        for (segment in segments(path)) {
            val next = current.findFile(segment)

            current = when {
                next == null ->
                    current.createDirectory(segment)
                        ?: throw SafException.OperationFailed(
                            "createDirectory",
                            path,
                        )

                next.isDirectory -> next

                else -> throw SafException.InvalidPath(path)
            }
        }

        return current
    }

    fun ensureFile(
        path: String,
        mimeType: String = MimeTypes.fromFileName(path),
    ): DocumentFile {
        val segments = segments(path)

        require(segments.isNotEmpty())

        val fileName = segments.last()

        val parent = ensureDirectory(
            segments.dropLast(1).joinToString("/"),
        )

        val existing = parent.findFile(fileName)

        if (existing != null) {
            if (!existing.isFile) {
                throw SafException.InvalidPath(path)
            }

            return existing
        }

        return parent.createFile(mimeType, fileName)
            ?: throw SafException.OperationFailed(
                "createFile",
                path,
            )
    }

    private fun segments(path: String): List<String> =
        path.trim('/')
            .split('/')
            .filter { it.isNotBlank() }
}