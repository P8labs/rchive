package com.example.flutter_saf.exception

sealed class SafException(
    message: String,
    cause: Throwable? = null,
) : Exception(message, cause) {

    abstract val code: String

    class InvalidTreeUri(val uri: String) : SafException("Invalid tree URI: $uri") {
        override val code = "INVALID_TREE_URI"
    }

    class FileNotFound(val path: String) : SafException("File not found: $path") {
        override val code = "FILE_NOT_FOUND"
    }

    class DirectoryNotFound(val path: String) : SafException("Directory not found: $path") {
        override val code = "DIRECTORY_NOT_FOUND"
    }

    class AlreadyExists(val path: String) : SafException("Already exists: $path") {
        override val code = "ALREADY_EXISTS"
    }

    class PermissionDenied(val path: String) : SafException("Permission denied: $path") {
        override val code = "PERMISSION_DENIED"
    }

    class InvalidPath(val path: String) : SafException("Invalid path: $path") {
        override val code = "INVALID_PATH"
    }

    class OperationFailed(
        val operation: String,
        val path: String,
        errorCause: Throwable? = null,
    ) : SafException("$operation failed: $path", errorCause) {
        override val code = "OPERATION_FAILED"
    }
}
