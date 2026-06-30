// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $VaultTableTable extends VaultTable
    with TableInfo<$VaultTableTable, VaultTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VaultTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _storageTypeMeta = const VerificationMeta(
    'storageType',
  );
  @override
  late final GeneratedColumn<String> storageType = GeneratedColumn<String>(
    'storage_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastOpenedAtMeta = const VerificationMeta(
    'lastOpenedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastOpenedAt = GeneratedColumn<DateTime>(
    'last_opened_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    location,
    storageType,
    version,
    createdAt,
    lastOpenedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vault_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<VaultTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('storage_type')) {
      context.handle(
        _storageTypeMeta,
        storageType.isAcceptableOrUnknown(
          data['storage_type']!,
          _storageTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_storageTypeMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_opened_at')) {
      context.handle(
        _lastOpenedAtMeta,
        lastOpenedAt.isAcceptableOrUnknown(
          data['last_opened_at']!,
          _lastOpenedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VaultTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VaultTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      )!,
      storageType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}storage_type'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastOpenedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_opened_at'],
      ),
    );
  }

  @override
  $VaultTableTable createAlias(String alias) {
    return $VaultTableTable(attachedDatabase, alias);
  }
}

class VaultTableData extends DataClass implements Insertable<VaultTableData> {
  final String id;
  final String name;

  /// Filesystem:
  ///   /storage/emulated/0/Documents/MyVault
  ///
  /// SAF:
  ///   content://com.android.externalstorage.documents/tree/...
  final String location;

  /// filesystem | saf
  final String storageType;
  final int version;
  final DateTime createdAt;
  final DateTime? lastOpenedAt;
  const VaultTableData({
    required this.id,
    required this.name,
    required this.location,
    required this.storageType,
    required this.version,
    required this.createdAt,
    this.lastOpenedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['location'] = Variable<String>(location);
    map['storage_type'] = Variable<String>(storageType);
    map['version'] = Variable<int>(version);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastOpenedAt != null) {
      map['last_opened_at'] = Variable<DateTime>(lastOpenedAt);
    }
    return map;
  }

  VaultTableCompanion toCompanion(bool nullToAbsent) {
    return VaultTableCompanion(
      id: Value(id),
      name: Value(name),
      location: Value(location),
      storageType: Value(storageType),
      version: Value(version),
      createdAt: Value(createdAt),
      lastOpenedAt: lastOpenedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastOpenedAt),
    );
  }

  factory VaultTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VaultTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      location: serializer.fromJson<String>(json['location']),
      storageType: serializer.fromJson<String>(json['storageType']),
      version: serializer.fromJson<int>(json['version']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastOpenedAt: serializer.fromJson<DateTime?>(json['lastOpenedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'location': serializer.toJson<String>(location),
      'storageType': serializer.toJson<String>(storageType),
      'version': serializer.toJson<int>(version),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastOpenedAt': serializer.toJson<DateTime?>(lastOpenedAt),
    };
  }

  VaultTableData copyWith({
    String? id,
    String? name,
    String? location,
    String? storageType,
    int? version,
    DateTime? createdAt,
    Value<DateTime?> lastOpenedAt = const Value.absent(),
  }) => VaultTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    location: location ?? this.location,
    storageType: storageType ?? this.storageType,
    version: version ?? this.version,
    createdAt: createdAt ?? this.createdAt,
    lastOpenedAt: lastOpenedAt.present ? lastOpenedAt.value : this.lastOpenedAt,
  );
  VaultTableData copyWithCompanion(VaultTableCompanion data) {
    return VaultTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      location: data.location.present ? data.location.value : this.location,
      storageType: data.storageType.present
          ? data.storageType.value
          : this.storageType,
      version: data.version.present ? data.version.value : this.version,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastOpenedAt: data.lastOpenedAt.present
          ? data.lastOpenedAt.value
          : this.lastOpenedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VaultTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('location: $location, ')
          ..write('storageType: $storageType, ')
          ..write('version: $version, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastOpenedAt: $lastOpenedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    location,
    storageType,
    version,
    createdAt,
    lastOpenedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VaultTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.location == this.location &&
          other.storageType == this.storageType &&
          other.version == this.version &&
          other.createdAt == this.createdAt &&
          other.lastOpenedAt == this.lastOpenedAt);
}

class VaultTableCompanion extends UpdateCompanion<VaultTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> location;
  final Value<String> storageType;
  final Value<int> version;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastOpenedAt;
  final Value<int> rowid;
  const VaultTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.location = const Value.absent(),
    this.storageType = const Value.absent(),
    this.version = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastOpenedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VaultTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String location,
    required String storageType,
    required int version,
    required DateTime createdAt,
    this.lastOpenedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name),
       location = Value(location),
       storageType = Value(storageType),
       version = Value(version),
       createdAt = Value(createdAt);
  static Insertable<VaultTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? location,
    Expression<String>? storageType,
    Expression<int>? version,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastOpenedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (location != null) 'location': location,
      if (storageType != null) 'storage_type': storageType,
      if (version != null) 'version': version,
      if (createdAt != null) 'created_at': createdAt,
      if (lastOpenedAt != null) 'last_opened_at': lastOpenedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VaultTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? location,
    Value<String>? storageType,
    Value<int>? version,
    Value<DateTime>? createdAt,
    Value<DateTime?>? lastOpenedAt,
    Value<int>? rowid,
  }) {
    return VaultTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      storageType: storageType ?? this.storageType,
      version: version ?? this.version,
      createdAt: createdAt ?? this.createdAt,
      lastOpenedAt: lastOpenedAt ?? this.lastOpenedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (storageType.present) {
      map['storage_type'] = Variable<String>(storageType.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastOpenedAt.present) {
      map['last_opened_at'] = Variable<DateTime>(lastOpenedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VaultTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('location: $location, ')
          ..write('storageType: $storageType, ')
          ..write('version: $version, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastOpenedAt: $lastOpenedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppConfigTableTable extends AppConfigTable
    with TableInfo<$AppConfigTableTable, AppConfigTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppConfigTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _defaultVaultIdMeta = const VerificationMeta(
    'defaultVaultId',
  );
  @override
  late final GeneratedColumn<String> defaultVaultId = GeneratedColumn<String>(
    'default_vault_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, defaultVaultId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_config_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppConfigTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('default_vault_id')) {
      context.handle(
        _defaultVaultIdMeta,
        defaultVaultId.isAcceptableOrUnknown(
          data['default_vault_id']!,
          _defaultVaultIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppConfigTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppConfigTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      defaultVaultId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_vault_id'],
      ),
    );
  }

  @override
  $AppConfigTableTable createAlias(String alias) {
    return $AppConfigTableTable(attachedDatabase, alias);
  }
}

class AppConfigTableData extends DataClass
    implements Insertable<AppConfigTableData> {
  final int id;
  final String? defaultVaultId;
  const AppConfigTableData({required this.id, this.defaultVaultId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || defaultVaultId != null) {
      map['default_vault_id'] = Variable<String>(defaultVaultId);
    }
    return map;
  }

  AppConfigTableCompanion toCompanion(bool nullToAbsent) {
    return AppConfigTableCompanion(
      id: Value(id),
      defaultVaultId: defaultVaultId == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultVaultId),
    );
  }

  factory AppConfigTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppConfigTableData(
      id: serializer.fromJson<int>(json['id']),
      defaultVaultId: serializer.fromJson<String?>(json['defaultVaultId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'defaultVaultId': serializer.toJson<String?>(defaultVaultId),
    };
  }

  AppConfigTableData copyWith({
    int? id,
    Value<String?> defaultVaultId = const Value.absent(),
  }) => AppConfigTableData(
    id: id ?? this.id,
    defaultVaultId: defaultVaultId.present
        ? defaultVaultId.value
        : this.defaultVaultId,
  );
  AppConfigTableData copyWithCompanion(AppConfigTableCompanion data) {
    return AppConfigTableData(
      id: data.id.present ? data.id.value : this.id,
      defaultVaultId: data.defaultVaultId.present
          ? data.defaultVaultId.value
          : this.defaultVaultId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppConfigTableData(')
          ..write('id: $id, ')
          ..write('defaultVaultId: $defaultVaultId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, defaultVaultId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppConfigTableData &&
          other.id == this.id &&
          other.defaultVaultId == this.defaultVaultId);
}

class AppConfigTableCompanion extends UpdateCompanion<AppConfigTableData> {
  final Value<int> id;
  final Value<String?> defaultVaultId;
  const AppConfigTableCompanion({
    this.id = const Value.absent(),
    this.defaultVaultId = const Value.absent(),
  });
  AppConfigTableCompanion.insert({
    this.id = const Value.absent(),
    this.defaultVaultId = const Value.absent(),
  });
  static Insertable<AppConfigTableData> custom({
    Expression<int>? id,
    Expression<String>? defaultVaultId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (defaultVaultId != null) 'default_vault_id': defaultVaultId,
    });
  }

  AppConfigTableCompanion copyWith({
    Value<int>? id,
    Value<String?>? defaultVaultId,
  }) {
    return AppConfigTableCompanion(
      id: id ?? this.id,
      defaultVaultId: defaultVaultId ?? this.defaultVaultId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (defaultVaultId.present) {
      map['default_vault_id'] = Variable<String>(defaultVaultId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppConfigTableCompanion(')
          ..write('id: $id, ')
          ..write('defaultVaultId: $defaultVaultId')
          ..write(')'))
        .toString();
  }
}

class $VaultFileTableTable extends VaultFileTable
    with TableInfo<$VaultFileTableTable, VaultFileTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VaultFileTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vaultIdMeta = const VerificationMeta(
    'vaultId',
  );
  @override
  late final GeneratedColumn<String> vaultId = GeneratedColumn<String>(
    'vault_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
    'path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<VaultEntryType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<VaultEntryType>($VaultFileTableTable.$convertertype);
  @override
  late final GeneratedColumnWithTypeConverter<VaultFileCategory, String>
  category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<VaultFileCategory>($VaultFileTableTable.$convertercategory);
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<int> size = GeneratedColumn<int>(
    'size',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastModifiedMeta = const VerificationMeta(
    'lastModified',
  );
  @override
  late final GeneratedColumn<DateTime> lastModified = GeneratedColumn<DateTime>(
    'last_modified',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _checksumMeta = const VerificationMeta(
    'checksum',
  );
  @override
  late final GeneratedColumn<String> checksum = GeneratedColumn<String>(
    'checksum',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _indexedAtMeta = const VerificationMeta(
    'indexedAt',
  );
  @override
  late final GeneratedColumn<DateTime> indexedAt = GeneratedColumn<DateTime>(
    'indexed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vaultId,
    path,
    type,
    category,
    size,
    lastModified,
    checksum,
    indexedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vault_file_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<VaultFileTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vault_id')) {
      context.handle(
        _vaultIdMeta,
        vaultId.isAcceptableOrUnknown(data['vault_id']!, _vaultIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vaultIdMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
        _pathMeta,
        path.isAcceptableOrUnknown(data['path']!, _pathMeta),
      );
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('size')) {
      context.handle(
        _sizeMeta,
        size.isAcceptableOrUnknown(data['size']!, _sizeMeta),
      );
    }
    if (data.containsKey('last_modified')) {
      context.handle(
        _lastModifiedMeta,
        lastModified.isAcceptableOrUnknown(
          data['last_modified']!,
          _lastModifiedMeta,
        ),
      );
    }
    if (data.containsKey('checksum')) {
      context.handle(
        _checksumMeta,
        checksum.isAcceptableOrUnknown(data['checksum']!, _checksumMeta),
      );
    }
    if (data.containsKey('indexed_at')) {
      context.handle(
        _indexedAtMeta,
        indexedAt.isAcceptableOrUnknown(data['indexed_at']!, _indexedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_indexedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {vaultId, path},
  ];
  @override
  VaultFileTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VaultFileTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      vaultId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vault_id'],
      )!,
      path: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}path'],
      )!,
      type: $VaultFileTableTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      category: $VaultFileTableTable.$convertercategory.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}category'],
        )!,
      ),
      size: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size'],
      ),
      lastModified: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_modified'],
      ),
      checksum: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}checksum'],
      ),
      indexedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}indexed_at'],
      )!,
    );
  }

  @override
  $VaultFileTableTable createAlias(String alias) {
    return $VaultFileTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<VaultEntryType, String, String> $convertertype =
      const EnumNameConverter<VaultEntryType>(VaultEntryType.values);
  static JsonTypeConverter2<VaultFileCategory, String, String>
  $convertercategory = const EnumNameConverter<VaultFileCategory>(
    VaultFileCategory.values,
  );
}

class VaultFileTableData extends DataClass
    implements Insertable<VaultFileTableData> {
  final String id;

  /// Foreign key to VaultTable.id
  final String vaultId;

  /// Relative path from vault root.
  /// Example:
  /// notes/daily.md
  /// attachments/logo.png
  final String path;

  /// File or directory.
  final VaultEntryType type;

  /// note / attachment / trash / metadata
  final VaultFileCategory category;
  final int? size;
  final DateTime? lastModified;

  /// SHA-256 or MD5
  final String? checksum;
  final DateTime indexedAt;
  const VaultFileTableData({
    required this.id,
    required this.vaultId,
    required this.path,
    required this.type,
    required this.category,
    this.size,
    this.lastModified,
    this.checksum,
    required this.indexedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vault_id'] = Variable<String>(vaultId);
    map['path'] = Variable<String>(path);
    {
      map['type'] = Variable<String>(
        $VaultFileTableTable.$convertertype.toSql(type),
      );
    }
    {
      map['category'] = Variable<String>(
        $VaultFileTableTable.$convertercategory.toSql(category),
      );
    }
    if (!nullToAbsent || size != null) {
      map['size'] = Variable<int>(size);
    }
    if (!nullToAbsent || lastModified != null) {
      map['last_modified'] = Variable<DateTime>(lastModified);
    }
    if (!nullToAbsent || checksum != null) {
      map['checksum'] = Variable<String>(checksum);
    }
    map['indexed_at'] = Variable<DateTime>(indexedAt);
    return map;
  }

  VaultFileTableCompanion toCompanion(bool nullToAbsent) {
    return VaultFileTableCompanion(
      id: Value(id),
      vaultId: Value(vaultId),
      path: Value(path),
      type: Value(type),
      category: Value(category),
      size: size == null && nullToAbsent ? const Value.absent() : Value(size),
      lastModified: lastModified == null && nullToAbsent
          ? const Value.absent()
          : Value(lastModified),
      checksum: checksum == null && nullToAbsent
          ? const Value.absent()
          : Value(checksum),
      indexedAt: Value(indexedAt),
    );
  }

  factory VaultFileTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VaultFileTableData(
      id: serializer.fromJson<String>(json['id']),
      vaultId: serializer.fromJson<String>(json['vaultId']),
      path: serializer.fromJson<String>(json['path']),
      type: $VaultFileTableTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      category: $VaultFileTableTable.$convertercategory.fromJson(
        serializer.fromJson<String>(json['category']),
      ),
      size: serializer.fromJson<int?>(json['size']),
      lastModified: serializer.fromJson<DateTime?>(json['lastModified']),
      checksum: serializer.fromJson<String?>(json['checksum']),
      indexedAt: serializer.fromJson<DateTime>(json['indexedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vaultId': serializer.toJson<String>(vaultId),
      'path': serializer.toJson<String>(path),
      'type': serializer.toJson<String>(
        $VaultFileTableTable.$convertertype.toJson(type),
      ),
      'category': serializer.toJson<String>(
        $VaultFileTableTable.$convertercategory.toJson(category),
      ),
      'size': serializer.toJson<int?>(size),
      'lastModified': serializer.toJson<DateTime?>(lastModified),
      'checksum': serializer.toJson<String?>(checksum),
      'indexedAt': serializer.toJson<DateTime>(indexedAt),
    };
  }

  VaultFileTableData copyWith({
    String? id,
    String? vaultId,
    String? path,
    VaultEntryType? type,
    VaultFileCategory? category,
    Value<int?> size = const Value.absent(),
    Value<DateTime?> lastModified = const Value.absent(),
    Value<String?> checksum = const Value.absent(),
    DateTime? indexedAt,
  }) => VaultFileTableData(
    id: id ?? this.id,
    vaultId: vaultId ?? this.vaultId,
    path: path ?? this.path,
    type: type ?? this.type,
    category: category ?? this.category,
    size: size.present ? size.value : this.size,
    lastModified: lastModified.present ? lastModified.value : this.lastModified,
    checksum: checksum.present ? checksum.value : this.checksum,
    indexedAt: indexedAt ?? this.indexedAt,
  );
  VaultFileTableData copyWithCompanion(VaultFileTableCompanion data) {
    return VaultFileTableData(
      id: data.id.present ? data.id.value : this.id,
      vaultId: data.vaultId.present ? data.vaultId.value : this.vaultId,
      path: data.path.present ? data.path.value : this.path,
      type: data.type.present ? data.type.value : this.type,
      category: data.category.present ? data.category.value : this.category,
      size: data.size.present ? data.size.value : this.size,
      lastModified: data.lastModified.present
          ? data.lastModified.value
          : this.lastModified,
      checksum: data.checksum.present ? data.checksum.value : this.checksum,
      indexedAt: data.indexedAt.present ? data.indexedAt.value : this.indexedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VaultFileTableData(')
          ..write('id: $id, ')
          ..write('vaultId: $vaultId, ')
          ..write('path: $path, ')
          ..write('type: $type, ')
          ..write('category: $category, ')
          ..write('size: $size, ')
          ..write('lastModified: $lastModified, ')
          ..write('checksum: $checksum, ')
          ..write('indexedAt: $indexedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vaultId,
    path,
    type,
    category,
    size,
    lastModified,
    checksum,
    indexedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VaultFileTableData &&
          other.id == this.id &&
          other.vaultId == this.vaultId &&
          other.path == this.path &&
          other.type == this.type &&
          other.category == this.category &&
          other.size == this.size &&
          other.lastModified == this.lastModified &&
          other.checksum == this.checksum &&
          other.indexedAt == this.indexedAt);
}

class VaultFileTableCompanion extends UpdateCompanion<VaultFileTableData> {
  final Value<String> id;
  final Value<String> vaultId;
  final Value<String> path;
  final Value<VaultEntryType> type;
  final Value<VaultFileCategory> category;
  final Value<int?> size;
  final Value<DateTime?> lastModified;
  final Value<String?> checksum;
  final Value<DateTime> indexedAt;
  final Value<int> rowid;
  const VaultFileTableCompanion({
    this.id = const Value.absent(),
    this.vaultId = const Value.absent(),
    this.path = const Value.absent(),
    this.type = const Value.absent(),
    this.category = const Value.absent(),
    this.size = const Value.absent(),
    this.lastModified = const Value.absent(),
    this.checksum = const Value.absent(),
    this.indexedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VaultFileTableCompanion.insert({
    required String id,
    required String vaultId,
    required String path,
    required VaultEntryType type,
    required VaultFileCategory category,
    this.size = const Value.absent(),
    this.lastModified = const Value.absent(),
    this.checksum = const Value.absent(),
    required DateTime indexedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       vaultId = Value(vaultId),
       path = Value(path),
       type = Value(type),
       category = Value(category),
       indexedAt = Value(indexedAt);
  static Insertable<VaultFileTableData> custom({
    Expression<String>? id,
    Expression<String>? vaultId,
    Expression<String>? path,
    Expression<String>? type,
    Expression<String>? category,
    Expression<int>? size,
    Expression<DateTime>? lastModified,
    Expression<String>? checksum,
    Expression<DateTime>? indexedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vaultId != null) 'vault_id': vaultId,
      if (path != null) 'path': path,
      if (type != null) 'type': type,
      if (category != null) 'category': category,
      if (size != null) 'size': size,
      if (lastModified != null) 'last_modified': lastModified,
      if (checksum != null) 'checksum': checksum,
      if (indexedAt != null) 'indexed_at': indexedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VaultFileTableCompanion copyWith({
    Value<String>? id,
    Value<String>? vaultId,
    Value<String>? path,
    Value<VaultEntryType>? type,
    Value<VaultFileCategory>? category,
    Value<int?>? size,
    Value<DateTime?>? lastModified,
    Value<String?>? checksum,
    Value<DateTime>? indexedAt,
    Value<int>? rowid,
  }) {
    return VaultFileTableCompanion(
      id: id ?? this.id,
      vaultId: vaultId ?? this.vaultId,
      path: path ?? this.path,
      type: type ?? this.type,
      category: category ?? this.category,
      size: size ?? this.size,
      lastModified: lastModified ?? this.lastModified,
      checksum: checksum ?? this.checksum,
      indexedAt: indexedAt ?? this.indexedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vaultId.present) {
      map['vault_id'] = Variable<String>(vaultId.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $VaultFileTableTable.$convertertype.toSql(type.value),
      );
    }
    if (category.present) {
      map['category'] = Variable<String>(
        $VaultFileTableTable.$convertercategory.toSql(category.value),
      );
    }
    if (size.present) {
      map['size'] = Variable<int>(size.value);
    }
    if (lastModified.present) {
      map['last_modified'] = Variable<DateTime>(lastModified.value);
    }
    if (checksum.present) {
      map['checksum'] = Variable<String>(checksum.value);
    }
    if (indexedAt.present) {
      map['indexed_at'] = Variable<DateTime>(indexedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VaultFileTableCompanion(')
          ..write('id: $id, ')
          ..write('vaultId: $vaultId, ')
          ..write('path: $path, ')
          ..write('type: $type, ')
          ..write('category: $category, ')
          ..write('size: $size, ')
          ..write('lastModified: $lastModified, ')
          ..write('checksum: $checksum, ')
          ..write('indexedAt: $indexedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $VaultTableTable vaultTable = $VaultTableTable(this);
  late final $AppConfigTableTable appConfigTable = $AppConfigTableTable(this);
  late final $VaultFileTableTable vaultFileTable = $VaultFileTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    vaultTable,
    appConfigTable,
    vaultFileTable,
  ];
}

typedef $$VaultTableTableCreateCompanionBuilder =
    VaultTableCompanion Function({
      Value<String> id,
      required String name,
      required String location,
      required String storageType,
      required int version,
      required DateTime createdAt,
      Value<DateTime?> lastOpenedAt,
      Value<int> rowid,
    });
typedef $$VaultTableTableUpdateCompanionBuilder =
    VaultTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> location,
      Value<String> storageType,
      Value<int> version,
      Value<DateTime> createdAt,
      Value<DateTime?> lastOpenedAt,
      Value<int> rowid,
    });

class $$VaultTableTableFilterComposer
    extends Composer<_$AppDatabase, $VaultTableTable> {
  $$VaultTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get storageType => $composableBuilder(
    column: $table.storageType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastOpenedAt => $composableBuilder(
    column: $table.lastOpenedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VaultTableTableOrderingComposer
    extends Composer<_$AppDatabase, $VaultTableTable> {
  $$VaultTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get storageType => $composableBuilder(
    column: $table.storageType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastOpenedAt => $composableBuilder(
    column: $table.lastOpenedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VaultTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $VaultTableTable> {
  $$VaultTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get storageType => $composableBuilder(
    column: $table.storageType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastOpenedAt => $composableBuilder(
    column: $table.lastOpenedAt,
    builder: (column) => column,
  );
}

class $$VaultTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VaultTableTable,
          VaultTableData,
          $$VaultTableTableFilterComposer,
          $$VaultTableTableOrderingComposer,
          $$VaultTableTableAnnotationComposer,
          $$VaultTableTableCreateCompanionBuilder,
          $$VaultTableTableUpdateCompanionBuilder,
          (
            VaultTableData,
            BaseReferences<_$AppDatabase, $VaultTableTable, VaultTableData>,
          ),
          VaultTableData,
          PrefetchHooks Function()
        > {
  $$VaultTableTableTableManager(_$AppDatabase db, $VaultTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VaultTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VaultTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VaultTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> location = const Value.absent(),
                Value<String> storageType = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lastOpenedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VaultTableCompanion(
                id: id,
                name: name,
                location: location,
                storageType: storageType,
                version: version,
                createdAt: createdAt,
                lastOpenedAt: lastOpenedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String name,
                required String location,
                required String storageType,
                required int version,
                required DateTime createdAt,
                Value<DateTime?> lastOpenedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VaultTableCompanion.insert(
                id: id,
                name: name,
                location: location,
                storageType: storageType,
                version: version,
                createdAt: createdAt,
                lastOpenedAt: lastOpenedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VaultTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VaultTableTable,
      VaultTableData,
      $$VaultTableTableFilterComposer,
      $$VaultTableTableOrderingComposer,
      $$VaultTableTableAnnotationComposer,
      $$VaultTableTableCreateCompanionBuilder,
      $$VaultTableTableUpdateCompanionBuilder,
      (
        VaultTableData,
        BaseReferences<_$AppDatabase, $VaultTableTable, VaultTableData>,
      ),
      VaultTableData,
      PrefetchHooks Function()
    >;
typedef $$AppConfigTableTableCreateCompanionBuilder =
    AppConfigTableCompanion Function({
      Value<int> id,
      Value<String?> defaultVaultId,
    });
typedef $$AppConfigTableTableUpdateCompanionBuilder =
    AppConfigTableCompanion Function({
      Value<int> id,
      Value<String?> defaultVaultId,
    });

class $$AppConfigTableTableFilterComposer
    extends Composer<_$AppDatabase, $AppConfigTableTable> {
  $$AppConfigTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultVaultId => $composableBuilder(
    column: $table.defaultVaultId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppConfigTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AppConfigTableTable> {
  $$AppConfigTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultVaultId => $composableBuilder(
    column: $table.defaultVaultId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppConfigTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppConfigTableTable> {
  $$AppConfigTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get defaultVaultId => $composableBuilder(
    column: $table.defaultVaultId,
    builder: (column) => column,
  );
}

class $$AppConfigTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppConfigTableTable,
          AppConfigTableData,
          $$AppConfigTableTableFilterComposer,
          $$AppConfigTableTableOrderingComposer,
          $$AppConfigTableTableAnnotationComposer,
          $$AppConfigTableTableCreateCompanionBuilder,
          $$AppConfigTableTableUpdateCompanionBuilder,
          (
            AppConfigTableData,
            BaseReferences<
              _$AppDatabase,
              $AppConfigTableTable,
              AppConfigTableData
            >,
          ),
          AppConfigTableData,
          PrefetchHooks Function()
        > {
  $$AppConfigTableTableTableManager(
    _$AppDatabase db,
    $AppConfigTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppConfigTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppConfigTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppConfigTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> defaultVaultId = const Value.absent(),
              }) => AppConfigTableCompanion(
                id: id,
                defaultVaultId: defaultVaultId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> defaultVaultId = const Value.absent(),
              }) => AppConfigTableCompanion.insert(
                id: id,
                defaultVaultId: defaultVaultId,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppConfigTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppConfigTableTable,
      AppConfigTableData,
      $$AppConfigTableTableFilterComposer,
      $$AppConfigTableTableOrderingComposer,
      $$AppConfigTableTableAnnotationComposer,
      $$AppConfigTableTableCreateCompanionBuilder,
      $$AppConfigTableTableUpdateCompanionBuilder,
      (
        AppConfigTableData,
        BaseReferences<_$AppDatabase, $AppConfigTableTable, AppConfigTableData>,
      ),
      AppConfigTableData,
      PrefetchHooks Function()
    >;
typedef $$VaultFileTableTableCreateCompanionBuilder =
    VaultFileTableCompanion Function({
      required String id,
      required String vaultId,
      required String path,
      required VaultEntryType type,
      required VaultFileCategory category,
      Value<int?> size,
      Value<DateTime?> lastModified,
      Value<String?> checksum,
      required DateTime indexedAt,
      Value<int> rowid,
    });
typedef $$VaultFileTableTableUpdateCompanionBuilder =
    VaultFileTableCompanion Function({
      Value<String> id,
      Value<String> vaultId,
      Value<String> path,
      Value<VaultEntryType> type,
      Value<VaultFileCategory> category,
      Value<int?> size,
      Value<DateTime?> lastModified,
      Value<String?> checksum,
      Value<DateTime> indexedAt,
      Value<int> rowid,
    });

class $$VaultFileTableTableFilterComposer
    extends Composer<_$AppDatabase, $VaultFileTableTable> {
  $$VaultFileTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vaultId => $composableBuilder(
    column: $table.vaultId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<VaultEntryType, VaultEntryType, String>
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<VaultFileCategory, VaultFileCategory, String>
  get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checksum => $composableBuilder(
    column: $table.checksum,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get indexedAt => $composableBuilder(
    column: $table.indexedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VaultFileTableTableOrderingComposer
    extends Composer<_$AppDatabase, $VaultFileTableTable> {
  $$VaultFileTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vaultId => $composableBuilder(
    column: $table.vaultId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checksum => $composableBuilder(
    column: $table.checksum,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get indexedAt => $composableBuilder(
    column: $table.indexedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VaultFileTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $VaultFileTableTable> {
  $$VaultFileTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get vaultId =>
      $composableBuilder(column: $table.vaultId, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumnWithTypeConverter<VaultEntryType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumnWithTypeConverter<VaultFileCategory, String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get size =>
      $composableBuilder(column: $table.size, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => column,
  );

  GeneratedColumn<String> get checksum =>
      $composableBuilder(column: $table.checksum, builder: (column) => column);

  GeneratedColumn<DateTime> get indexedAt =>
      $composableBuilder(column: $table.indexedAt, builder: (column) => column);
}

class $$VaultFileTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VaultFileTableTable,
          VaultFileTableData,
          $$VaultFileTableTableFilterComposer,
          $$VaultFileTableTableOrderingComposer,
          $$VaultFileTableTableAnnotationComposer,
          $$VaultFileTableTableCreateCompanionBuilder,
          $$VaultFileTableTableUpdateCompanionBuilder,
          (
            VaultFileTableData,
            BaseReferences<
              _$AppDatabase,
              $VaultFileTableTable,
              VaultFileTableData
            >,
          ),
          VaultFileTableData,
          PrefetchHooks Function()
        > {
  $$VaultFileTableTableTableManager(
    _$AppDatabase db,
    $VaultFileTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VaultFileTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VaultFileTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VaultFileTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> vaultId = const Value.absent(),
                Value<String> path = const Value.absent(),
                Value<VaultEntryType> type = const Value.absent(),
                Value<VaultFileCategory> category = const Value.absent(),
                Value<int?> size = const Value.absent(),
                Value<DateTime?> lastModified = const Value.absent(),
                Value<String?> checksum = const Value.absent(),
                Value<DateTime> indexedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VaultFileTableCompanion(
                id: id,
                vaultId: vaultId,
                path: path,
                type: type,
                category: category,
                size: size,
                lastModified: lastModified,
                checksum: checksum,
                indexedAt: indexedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String vaultId,
                required String path,
                required VaultEntryType type,
                required VaultFileCategory category,
                Value<int?> size = const Value.absent(),
                Value<DateTime?> lastModified = const Value.absent(),
                Value<String?> checksum = const Value.absent(),
                required DateTime indexedAt,
                Value<int> rowid = const Value.absent(),
              }) => VaultFileTableCompanion.insert(
                id: id,
                vaultId: vaultId,
                path: path,
                type: type,
                category: category,
                size: size,
                lastModified: lastModified,
                checksum: checksum,
                indexedAt: indexedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VaultFileTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VaultFileTableTable,
      VaultFileTableData,
      $$VaultFileTableTableFilterComposer,
      $$VaultFileTableTableOrderingComposer,
      $$VaultFileTableTableAnnotationComposer,
      $$VaultFileTableTableCreateCompanionBuilder,
      $$VaultFileTableTableUpdateCompanionBuilder,
      (
        VaultFileTableData,
        BaseReferences<_$AppDatabase, $VaultFileTableTable, VaultFileTableData>,
      ),
      VaultFileTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$VaultTableTableTableManager get vaultTable =>
      $$VaultTableTableTableManager(_db, _db.vaultTable);
  $$AppConfigTableTableTableManager get appConfigTable =>
      $$AppConfigTableTableTableManager(_db, _db.appConfigTable);
  $$VaultFileTableTableTableManager get vaultFileTable =>
      $$VaultFileTableTableTableManager(_db, _db.vaultFileTable);
}
