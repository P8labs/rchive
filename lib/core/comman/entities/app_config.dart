import 'package:drift/drift.dart';
import 'package:rchive/core/database/app_database.dart';

class AppConfig {
  static const defaultConfigId = 1;
  final int id;
  final String? defaultVaultId;
  const AppConfig({this.id = defaultConfigId, this.defaultVaultId});

  AppConfig copyWith({int? id, String? defaultVaultId}) {
    return AppConfig(
      id: id ?? this.id,
      defaultVaultId: defaultVaultId ?? this.defaultVaultId,
    );
  }

  factory AppConfig.initial() {
    return AppConfig(id: defaultConfigId);
  }

  factory AppConfig.fromDrift(AppConfigTableData row) {
    return AppConfig(id: row.id, defaultVaultId: row.defaultVaultId);
  }

  AppConfigTableCompanion toCompanion() {
    return AppConfigTableCompanion(
      id: Value(id),
      defaultVaultId: Value(defaultVaultId),
    );
  }
}
