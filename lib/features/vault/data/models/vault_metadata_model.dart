import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:rchive/core/comman/entities/vault.dart';

class VaultMetadataModel extends Vault {
  static const fileName = 'vault.json';

  const VaultMetadataModel({
    required super.id,
    required super.name,
    required super.path,
    required super.version,
    required super.createdAt,
    super.lastOpenedAt,
  });

  factory VaultMetadataModel.fromEntity(Vault vault) {
    return VaultMetadataModel(
      id: vault.id,
      name: vault.name,
      path: vault.path,
      version: vault.version,
      createdAt: vault.createdAt,
      lastOpenedAt: vault.lastOpenedAt,
    );
  }

  factory VaultMetadataModel.fromJson({
    required String path,
    required Map<String, dynamic> json,
  }) {
    return VaultMetadataModel(
      id: json['id'] as String,
      name: json['name'] as String,
      path: path,
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

  Future<void> save() async {
    final file = File(p.join(path, fileName));

    await file.writeAsString(
      const JsonEncoder.withIndent('  ').convert(toJson()),
      flush: true,
    );
  }

  static Future<VaultMetadataModel> load(String vaultPath) async {
    final file = File(p.join(vaultPath, fileName));

    final json = jsonDecode(await file.readAsString()) as Map<String, dynamic>;

    return VaultMetadataModel.fromJson(path: vaultPath, json: json);
  }

  Vault toEntity() {
    return Vault(
      id: id,
      name: name,
      path: path,
      version: version,
      createdAt: createdAt,
      lastOpenedAt: lastOpenedAt,
    );
  }
}
