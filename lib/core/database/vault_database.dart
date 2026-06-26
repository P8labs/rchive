import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;

import 'tables/vault/note_table.dart';

part 'vault_database.g.dart';

@DriftDatabase(tables: [Notes])
class VaultDatabase extends _$VaultDatabase {
  VaultDatabase({required String vaultPath})
    : super(_openConnection(vaultPath));

  @override
  int get schemaVersion => 1;
}

QueryExecutor _openConnection(String vaultPath) {
  return NativeDatabase.createInBackground(File(p.join(vaultPath, 'vault.db')));
}
