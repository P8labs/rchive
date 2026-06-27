enum DocumentType {
  file,
  directory;

  factory DocumentType.fromName(String name) {
    return switch (name) {
      'file' => DocumentType.file,
      'directory' => DocumentType.directory,
      _ => throw ArgumentError.value(name, 'name', 'Unknown document type'),
    };
  }
}
