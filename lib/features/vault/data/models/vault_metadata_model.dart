import 'dart:convert';

import 'package:rchive/core/comman/entities/vault.dart';
import 'package:rchive/features/vault/constants/vault_constants.dart';
import 'package:rchive/features/vault/data/storage/vault_storage.dart';

class VaultMetadataModel extends Vault {
  static const fileName = 'vault.json';

  const VaultMetadataModel({
    required super.id,
    required super.name,
    required super.location,
    required super.storageType,
    required super.version,
    required super.createdAt,
    super.lastOpenedAt,
  });

  factory VaultMetadataModel.fromEntity(Vault vault) {
    return VaultMetadataModel(
      id: vault.id,
      name: vault.name,
      location: vault.location,
      storageType: vault.storageType,
      version: vault.version,
      createdAt: vault.createdAt,
      lastOpenedAt: vault.lastOpenedAt,
    );
  }

  factory VaultMetadataModel.fromJson({
    required String location,
    required VaultStorageType storageType,
    required Map<String, dynamic> json,
  }) {
    return VaultMetadataModel(
      id: json['id'] as String,
      name: json['name'] as String,
      location: location,
      storageType: storageType,
      version: json['version'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastOpenedAt: json['lastOpenedAt'] == null
          ? null
          : DateTime.parse(json['lastOpenedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'version': version,
      'createdAt': createdAt.toUtc().toIso8601String(),
      'lastOpenedAt': lastOpenedAt?.toUtc().toIso8601String(),
    };
  }

  Future<void> save({
    required VaultStorage vaultStorage,
    required VaultStorageType storageType,
  }) async {
    final json = const JsonEncoder.withIndent('  ').convert(toJson());
    await vaultStorage.write(VaultConstants.metadataFile, utf8.encode(json));
  }

  static Future<VaultMetadataModel> load({
    required VaultStorage vaultStorage,
    required VaultStorageType storageType,
  }) async {
    final raw = await vaultStorage.read(VaultConstants.metadataFile);
    final json = jsonDecode(utf8.decode(raw)) as Map<String, dynamic>;
    return VaultMetadataModel.fromJson(
      location: vaultStorage.location,
      storageType: storageType,
      json: json,
    );
  }

  Vault toEntity() {
    return Vault(
      id: id,
      name: name,
      location: location,
      storageType: storageType,
      version: version,
      createdAt: createdAt,
      lastOpenedAt: lastOpenedAt,
    );
  }
}
