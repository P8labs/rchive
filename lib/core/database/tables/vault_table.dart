import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class VaultTable extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();

  TextColumn get name => text()();

  /// Vault folder name
  TextColumn get location => text()();

  /// Filesystem:
  ///   /storage/emulated/0/Documents/MyVault
  ///
  /// SAF:
  ///   content://com.android.externalstorage.documents/tree/...
  TextColumn get treeUri => text().unique()();

  /// filesystem | saf
  TextColumn get storageType => text()();

  IntColumn get version => integer()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get lastOpenedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
