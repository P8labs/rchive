import 'document_type.dart';

class DocumentEntry {
  final String name;

  /// Relative path from the selected root.
  ///
  /// Examples:
  /// notes
  /// notes/daily.md
  /// assets/logo.png
  final String path;

  final DocumentType type;

  /// Size in bytes.
  ///
  /// Null for directories.
  final int? size;

  /// Unix timestamp in milliseconds.
  final DateTime? lastModified;

  const DocumentEntry({
    required this.name,
    required this.path,
    required this.type,
    this.size,
    this.lastModified,
  });

  bool get isFile => type == DocumentType.file;

  bool get isDirectory => type == DocumentType.directory;

  factory DocumentEntry.fromMap(Map<Object?, Object?> map) {
    return DocumentEntry(
      name: map['name'] as String,
      path: map['path'] as String,
      type: DocumentType.fromName(map['type'] as String),
      size: map['size'] as int?,
      lastModified: map['lastModified'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['lastModified'] as int),
    );
  }

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'path': path,
      'type': type.name,
      'size': size,
      'lastModified': lastModified?.millisecondsSinceEpoch,
    };
  }
}
