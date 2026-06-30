import 'package:drift/drift.dart';

class AppConfigTable extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  TextColumn get defaultVaultId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
