import 'dart:io';

import 'package:drift/native.dart';
import 'package:path/path.dart' as p;

import 'database.dart';

abstract interface class DatabaseService {
  bool get isOpen;
  AppDatabase get database;

  Future<void> open({required String vaultPath});
  Future<void> close();
}

class DatabaseServiceImpl implements DatabaseService {
  AppDatabase? _database;

  @override
  bool get isOpen => _database != null;

  @override
  AppDatabase get database {
    final db = _database;

    if (db == null) {
      throw StateError('Database has not been opened.');
    }

    return db;
  }

  @override
  Future<void> open({required String vaultPath}) async {
    await close();

    final file = File(p.join(vaultPath, 'vault.db'));
    _database = AppDatabase(NativeDatabase(file));
  }

  @override
  Future<void> close() async {
    await _database?.close();
    _database = null;
  }
}
