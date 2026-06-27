package com.example.flutter_saf.document

import android.content.ContentResolver
import android.content.Context
import android.net.Uri
import com.example.flutter_saf.exception.SafException
import java.io.IOException

class DocumentService(
    context: Context,
    treeUri: Uri,
) {
    private val contentResolver: ContentResolver = context.contentResolver

    private val navigator = DocumentNavigator(
        context = context,
        treeUri = treeUri,
    )

    fun exists(path: String): Boolean {
        return navigator.resolve(path) != null
    }

    fun list(path: String): List<DocumentEntry> {
        val directory = navigator.resolve(path)
            ?: throw SafException.DirectoryNotFound(path)

        if (!directory.isDirectory) {
            throw SafException.InvalidPath(path)
        }

        return directory.listFiles().map { document ->
            val relativePath = if (path.isBlank()) {
                document.name.orEmpty()
            } else {
                "$path/${document.name.orEmpty()}"
            }

            DocumentEntry(
                name = document.name.orEmpty(),
                path = relativePath,
                type = if (document.isDirectory) {
                    DocumentType.DIRECTORY
                } else {
                    DocumentType.FILE
                },
                size = if (document.isFile) document.length() else null,
                lastModified = document.lastModified(),
            )
        }
    }

    @Throws(IOException::class)
    fun read(path: String): ByteArray {
        val file = navigator.resolve(path)
            ?: throw SafException.FileNotFound(path)

        if (!file.isFile) {
            throw SafException.InvalidPath(path)
        }

        return contentResolver.openInputStream(file.uri)?.use {
            it.readBytes()
        } ?: throw SafException.OperationFailed("read", path)
    }

    @Throws(IOException::class)
    fun write(
        path: String,
        bytes: ByteArray,
    ) {
        val file = navigator.ensureFile(path)

        contentResolver.openOutputStream(file.uri, "wt")?.use {
            it.write(bytes)
        } ?: throw SafException.OperationFailed("write", path)
    }

    fun createDirectory(path: String) {
        navigator.ensureDirectory(path)
    }

    fun delete(
        path: String,
        recursive: Boolean = false,
    ) {
        val document = navigator.resolve(path)
            ?: throw SafException.FileNotFound(path)

        if (document.isDirectory && !recursive && document.listFiles().isNotEmpty()) {
            throw SafException.OperationFailed("delete", path)
        }

        if (!document.delete()) {
            throw SafException.OperationFailed("delete", path)
        }
    }

    fun rename(
        path: String,
        newName: String,
    ) {
        val document = navigator.resolve(path)
            ?: throw SafException.FileNotFound(path)

        if (!document.renameTo(newName)) {
            throw SafException.OperationFailed("rename", path)
        }
    }
}