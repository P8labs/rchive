class Vault {
  final String id;
  final String name;

  final String path;
  final int version;

  final DateTime createdAt;
  final DateTime? lastOpenedAt;

  const Vault({
    required this.id,
    required this.name,
    required this.path,
    required this.version,
    required this.createdAt,
    this.lastOpenedAt,
  });

  Vault copyWith({
    String? id,
    String? name,
    String? path,
    int? version,
    DateTime? createdAt,
    DateTime? lastOpenedAt,
  }) {
    return Vault(
      id: id ?? this.id,
      name: name ?? this.name,
      path: path ?? this.path,
      version: version ?? this.version,
      createdAt: createdAt ?? this.createdAt,
      lastOpenedAt: lastOpenedAt ?? this.lastOpenedAt,
    );
  }
}
