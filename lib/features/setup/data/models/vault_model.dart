import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

import 'package:rchive/core/error/exceptions.dart';
import 'package:rchive/core/comman/entities/vault.dart';

import 'package:rchive/features/vault/constants/vault_constants.dart';

class VaultModel extends Vault {
  static const _uuid = Uuid();

  const VaultModel({
    required super.id,
    required super.name,
    required super.path,
    required super.version,
    required super.createdAt,
  });

  factory VaultModel.create({required String name, required String path}) {
    return VaultModel(
      id: _uuid.v4(),
      name: name,
      path: path,
      version: VaultConstants.currentVersion,
      createdAt: DateTime.now().toUtc(),
    );
  }

  factory VaultModel.fromJson({
    required String path,
    required Map<String, dynamic> json,
  }) {
    return VaultModel(
      id: json['id'] as String,
      name: json['name'] as String,
      path: path,
      version: json['version'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'version': version,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  Future<void> save() async {
    final file = File(p.join(path, VaultConstants.metadataFile));

    await file.writeAsString(
      const JsonEncoder.withIndent('  ').convert(toJson()),
      flush: true,
    );
  }

  static Future<VaultModel> load(String path) async {
    final file = File(p.join(path, VaultConstants.metadataFile));

    if (!await file.exists()) {
      throw Exception('vault.json not found.');
    }

    final json = jsonDecode(await file.readAsString()) as Map<String, dynamic>;

    if (json['version'] != VaultConstants.currentVersion) {
      throw LocalException('Unsupported vault version: ${json['version']}');
    }
    return VaultModel.fromJson(path: path, json: json);
  }
}
