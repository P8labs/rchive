package com.example.flutter_saf.exception

sealed class SafException(
    override val message: String,
) : Exception(message) {

    data class InvalidTreeUri(
        val uri: String,
    ) : SafException("Invalid tree URI: $uri")

    data class FileNotFound(
        val path: String,
    ) : SafException("File not found: $path")

    data class DirectoryNotFound(
        val path: String,
    ) : SafException("Directory not found: $path")

    data class AlreadyExists(
        val path: String,
    ) : SafException("Already exists: $path")

    data class PermissionDenied(
        val path: String,
    ) : SafException("Permission denied: $path")

    data class InvalidPath(
        val path: String,
    ) : SafException("Invalid path: $path")

    data class OperationFailed(
        val operation: String,
        val path: String,
        val cause: Throwable? = null,
    ) : SafException("$operation failed: $path") {
        override val cause: Throwable? = cause
    }
}