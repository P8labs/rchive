package com.example.flutter_saf.util

object MimeTypes {
    const val DIRECTORY = "vnd.android.document/directory"

    const val TEXT = "text/plain"
    const val MARKDOWN = "text/markdown"

    const val JSON = "application/json"

    const val JPEG = "image/jpeg"
    const val PNG = "image/png"
    const val GIF = "image/gif"
    const val WEBP = "image/webp"
    const val SVG = "image/svg+xml"

    const val PDF = "application/pdf"

    const val OCTET_STREAM = "application/octet-stream"

    fun fromFileName(fileName: String): String {
        val extension = fileName.substringAfterLast('.', "").lowercase()

        return when (extension) {
            "md", "markdown" -> MARKDOWN
            "txt" -> TEXT
            "json" -> JSON

            "jpg", "jpeg" -> JPEG
            "png" -> PNG
            "gif" -> GIF
            "webp" -> WEBP
            "svg" -> SVG

            "pdf" -> PDF

            else -> OCTET_STREAM
        }
    }
}