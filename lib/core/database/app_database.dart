import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:rchive/core/database/tables/app/config_table.dart';
import 'package:rchive/core/database/tables/app/vault_table.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';
part 'app_database.g.dart';

@DriftDatabase(tables: [VaultTable, ConfigTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 1;
}

AppDatabase openConnection(String path) {
  return AppDatabase(NativeDatabase(File(p.join(path, 'rchive.db'))));
}
