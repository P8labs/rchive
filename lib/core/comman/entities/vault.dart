enum VaultStorageType { saf, filesystem }

class Vault {
  final String id;
  final String name;

  /// Platform-specific root identifier.
  ///
  /// Filesystem:
  ///   /home/user/Documents/MyVault
  ///
  /// Android SAF:
  ///   content://com.android.externalstorage.documents/tree/...
  final String location;

  final VaultStorageType storageType;

  final int version;

  final DateTime createdAt;
  final DateTime? lastOpenedAt;

  const Vault({
    required this.id,
    required this.name,
    required this.location,
    required this.storageType,
    required this.version,
    required this.createdAt,
    this.lastOpenedAt,
  });

  Vault copyWith({
    String? id,
    String? name,
    String? location,
    VaultStorageType? storageType,
    int? version,
    DateTime? createdAt,
    DateTime? lastOpenedAt,
  }) {
    return Vault(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      storageType: storageType ?? this.storageType,
      version: version ?? this.version,
      createdAt: createdAt ?? this.createdAt,
      lastOpenedAt: lastOpenedAt ?? this.lastOpenedAt,
    );
  }
}
