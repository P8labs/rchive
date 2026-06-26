import 'package:drift/drift.dart';

class Notes extends Table {
  TextColumn get id => text()();

  TextColumn get title => text().withDefault(const Constant('Untitled'))();
  TextColumn get relativePath => text()();
  BoolColumn get pinned => boolean().withDefault(const Constant(false))();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  TextColumn get parentId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
