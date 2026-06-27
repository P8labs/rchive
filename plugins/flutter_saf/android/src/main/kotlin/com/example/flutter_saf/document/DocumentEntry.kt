package com.example.flutter_saf.document

data class DocumentEntry(
    /**
     * Name of the file or directory.
     *
     * Examples:
     * notes
     * daily.md
     * image.png
     */
    val name: String,

    /**
     * Relative path from the selected root.
     *
     * Examples:
     * notes
     * notes/daily.md
     * assets/logo.png
     */
    val path: String,

    val type: DocumentType,

    /**
     * Size in bytes.
     *
     * Null for directories.
     */
    val size: Long? = null,

    /**
     * Unix timestamp in milliseconds.
     */
    val lastModified: Long? = null,
)

enum class DocumentType {
    FILE,
    DIRECTORY,
}