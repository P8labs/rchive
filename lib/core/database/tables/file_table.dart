import 'package:drift/drift.dart';
import 'package:rchive/features/vault/data/storage/vault_storage.dart';

class VaultFileTable extends Table {
  /// Foreign key to VaultTable.id
  TextColumn get vaultId => text()();

  /// Relative path from vault root.
  /// Example:
  /// notes/daily.md
  /// attachments/logo.png
  TextColumn get path => text()();

  /// File or directory.
  TextColumn get type => textEnum<VaultEntryType>()();

  /// note / attachment / trash / metadata
  TextColumn get category => textEnum<VaultFileCategory>()();

  IntColumn get size => integer().nullable()();

  DateTimeColumn get lastModified => dateTime().nullable()();

  /// SHA-256 or MD5
  TextColumn get checksum => text().nullable()();

  DateTimeColumn get indexedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {vaultId, path};
}

enum VaultFileCategory { metadata, note, attachment, trash }
