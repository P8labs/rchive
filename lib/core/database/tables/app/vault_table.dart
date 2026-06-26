import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class VaultTable extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get name => text()();
  TextColumn get path => text().unique()();
  IntColumn get version => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get lastOpenedAt => dateTime().nullable()();

  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  @override
  Set<Column> get primaryKey => {id};
}
