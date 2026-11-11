// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AnimalEntriesTable extends AnimalEntries
    with TableInfo<$AnimalEntriesTable, AnimalEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnimalEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _commonNameMeta = const VerificationMeta(
    'commonName',
  );
  @override
  late final GeneratedColumn<String> commonName = GeneratedColumn<String>(
    'common_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 2,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scientificNameMeta = const VerificationMeta(
    'scientificName',
  );
  @override
  late final GeneratedColumn<String> scientificName = GeneratedColumn<String>(
    'scientific_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 2,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _habitatMeta = const VerificationMeta(
    'habitat',
  );
  @override
  late final GeneratedColumn<String> habitat = GeneratedColumn<String>(
    'habitat',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('quantity > 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conservationStatusMeta =
      const VerificationMeta('conservationStatus');
  @override
  late final GeneratedColumn<String> conservationStatus =
      GeneratedColumn<String>(
        'conservation_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    commonName,
    scientificName,
    habitat,
    quantity,
    conservationStatus,
    notes,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'animal_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<AnimalEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('common_name')) {
      context.handle(
        _commonNameMeta,
        commonName.isAcceptableOrUnknown(data['common_name']!, _commonNameMeta),
      );
    } else if (isInserting) {
      context.missing(_commonNameMeta);
    }
    if (data.containsKey('scientific_name')) {
      context.handle(
        _scientificNameMeta,
        scientificName.isAcceptableOrUnknown(
          data['scientific_name']!,
          _scientificNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scientificNameMeta);
    }
    if (data.containsKey('habitat')) {
      context.handle(
        _habitatMeta,
        habitat.isAcceptableOrUnknown(data['habitat']!, _habitatMeta),
      );
    } else if (isInserting) {
      context.missing(_habitatMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('conservation_status')) {
      context.handle(
        _conservationStatusMeta,
        conservationStatus.isAcceptableOrUnknown(
          data['conservation_status']!,
          _conservationStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_conservationStatusMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AnimalEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AnimalEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      commonName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}common_name'],
      )!,
      scientificName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scientific_name'],
      )!,
      habitat: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habitat'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      conservationStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}conservation_status'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AnimalEntriesTable createAlias(String alias) {
    return $AnimalEntriesTable(attachedDatabase, alias);
  }
}

class AnimalEntry extends DataClass implements Insertable<AnimalEntry> {
  final int id;
  final String commonName;
  final String scientificName;
  final String habitat;
  final int quantity;
  final String conservationStatus;
  final String notes;
  final DateTime updatedAt;
  const AnimalEntry({
    required this.id,
    required this.commonName,
    required this.scientificName,
    required this.habitat,
    required this.quantity,
    required this.conservationStatus,
    required this.notes,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['common_name'] = Variable<String>(commonName);
    map['scientific_name'] = Variable<String>(scientificName);
    map['habitat'] = Variable<String>(habitat);
    map['quantity'] = Variable<int>(quantity);
    map['conservation_status'] = Variable<String>(conservationStatus);
    map['notes'] = Variable<String>(notes);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AnimalEntriesCompanion toCompanion(bool nullToAbsent) {
    return AnimalEntriesCompanion(
      id: Value(id),
      commonName: Value(commonName),
      scientificName: Value(scientificName),
      habitat: Value(habitat),
      quantity: Value(quantity),
      conservationStatus: Value(conservationStatus),
      notes: Value(notes),
      updatedAt: Value(updatedAt),
    );
  }

  factory AnimalEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AnimalEntry(
      id: serializer.fromJson<int>(json['id']),
      commonName: serializer.fromJson<String>(json['commonName']),
      scientificName: serializer.fromJson<String>(json['scientificName']),
      habitat: serializer.fromJson<String>(json['habitat']),
      quantity: serializer.fromJson<int>(json['quantity']),
      conservationStatus: serializer.fromJson<String>(
        json['conservationStatus'],
      ),
      notes: serializer.fromJson<String>(json['notes']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'commonName': serializer.toJson<String>(commonName),
      'scientificName': serializer.toJson<String>(scientificName),
      'habitat': serializer.toJson<String>(habitat),
      'quantity': serializer.toJson<int>(quantity),
      'conservationStatus': serializer.toJson<String>(conservationStatus),
      'notes': serializer.toJson<String>(notes),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AnimalEntry copyWith({
    int? id,
    String? commonName,
    String? scientificName,
    String? habitat,
    int? quantity,
    String? conservationStatus,
    String? notes,
    DateTime? updatedAt,
  }) => AnimalEntry(
    id: id ?? this.id,
    commonName: commonName ?? this.commonName,
    scientificName: scientificName ?? this.scientificName,
    habitat: habitat ?? this.habitat,
    quantity: quantity ?? this.quantity,
    conservationStatus: conservationStatus ?? this.conservationStatus,
    notes: notes ?? this.notes,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AnimalEntry copyWithCompanion(AnimalEntriesCompanion data) {
    return AnimalEntry(
      id: data.id.present ? data.id.value : this.id,
      commonName: data.commonName.present
          ? data.commonName.value
          : this.commonName,
      scientificName: data.scientificName.present
          ? data.scientificName.value
          : this.scientificName,
      habitat: data.habitat.present ? data.habitat.value : this.habitat,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      conservationStatus: data.conservationStatus.present
          ? data.conservationStatus.value
          : this.conservationStatus,
      notes: data.notes.present ? data.notes.value : this.notes,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AnimalEntry(')
          ..write('id: $id, ')
          ..write('commonName: $commonName, ')
          ..write('scientificName: $scientificName, ')
          ..write('habitat: $habitat, ')
          ..write('quantity: $quantity, ')
          ..write('conservationStatus: $conservationStatus, ')
          ..write('notes: $notes, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    commonName,
    scientificName,
    habitat,
    quantity,
    conservationStatus,
    notes,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AnimalEntry &&
          other.id == this.id &&
          other.commonName == this.commonName &&
          other.scientificName == this.scientificName &&
          other.habitat == this.habitat &&
          other.quantity == this.quantity &&
          other.conservationStatus == this.conservationStatus &&
          other.notes == this.notes &&
          other.updatedAt == this.updatedAt);
}

class AnimalEntriesCompanion extends UpdateCompanion<AnimalEntry> {
  final Value<int> id;
  final Value<String> commonName;
  final Value<String> scientificName;
  final Value<String> habitat;
  final Value<int> quantity;
  final Value<String> conservationStatus;
  final Value<String> notes;
  final Value<DateTime> updatedAt;
  const AnimalEntriesCompanion({
    this.id = const Value.absent(),
    this.commonName = const Value.absent(),
    this.scientificName = const Value.absent(),
    this.habitat = const Value.absent(),
    this.quantity = const Value.absent(),
    this.conservationStatus = const Value.absent(),
    this.notes = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AnimalEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String commonName,
    required String scientificName,
    required String habitat,
    required int quantity,
    required String conservationStatus,
    this.notes = const Value.absent(),
    required DateTime updatedAt,
  }) : commonName = Value(commonName),
       scientificName = Value(scientificName),
       habitat = Value(habitat),
       quantity = Value(quantity),
       conservationStatus = Value(conservationStatus),
       updatedAt = Value(updatedAt);
  static Insertable<AnimalEntry> custom({
    Expression<int>? id,
    Expression<String>? commonName,
    Expression<String>? scientificName,
    Expression<String>? habitat,
    Expression<int>? quantity,
    Expression<String>? conservationStatus,
    Expression<String>? notes,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (commonName != null) 'common_name': commonName,
      if (scientificName != null) 'scientific_name': scientificName,
      if (habitat != null) 'habitat': habitat,
      if (quantity != null) 'quantity': quantity,
      if (conservationStatus != null) 'conservation_status': conservationStatus,
      if (notes != null) 'notes': notes,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AnimalEntriesCompanion copyWith({
    Value<int>? id,
    Value<String>? commonName,
    Value<String>? scientificName,
    Value<String>? habitat,
    Value<int>? quantity,
    Value<String>? conservationStatus,
    Value<String>? notes,
    Value<DateTime>? updatedAt,
  }) {
    return AnimalEntriesCompanion(
      id: id ?? this.id,
      commonName: commonName ?? this.commonName,
      scientificName: scientificName ?? this.scientificName,
      habitat: habitat ?? this.habitat,
      quantity: quantity ?? this.quantity,
      conservationStatus: conservationStatus ?? this.conservationStatus,
      notes: notes ?? this.notes,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (commonName.present) {
      map['common_name'] = Variable<String>(commonName.value);
    }
    if (scientificName.present) {
      map['scientific_name'] = Variable<String>(scientificName.value);
    }
    if (habitat.present) {
      map['habitat'] = Variable<String>(habitat.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (conservationStatus.present) {
      map['conservation_status'] = Variable<String>(conservationStatus.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnimalEntriesCompanion(')
          ..write('id: $id, ')
          ..write('commonName: $commonName, ')
          ..write('scientificName: $scientificName, ')
          ..write('habitat: $habitat, ')
          ..write('quantity: $quantity, ')
          ..write('conservationStatus: $conservationStatus, ')
          ..write('notes: $notes, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AnimalEntriesTable animalEntries = $AnimalEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [animalEntries];
}

typedef $$AnimalEntriesTableCreateCompanionBuilder =
    AnimalEntriesCompanion Function({
      Value<int> id,
      required String commonName,
      required String scientificName,
      required String habitat,
      required int quantity,
      required String conservationStatus,
      Value<String> notes,
      required DateTime updatedAt,
    });
typedef $$AnimalEntriesTableUpdateCompanionBuilder =
    AnimalEntriesCompanion Function({
      Value<int> id,
      Value<String> commonName,
      Value<String> scientificName,
      Value<String> habitat,
      Value<int> quantity,
      Value<String> conservationStatus,
      Value<String> notes,
      Value<DateTime> updatedAt,
    });

class $$AnimalEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $AnimalEntriesTable> {
  $$AnimalEntriesTableFilterComposer({
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

  ColumnFilters<String> get commonName => $composableBuilder(
    column: $table.commonName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scientificName => $composableBuilder(
    column: $table.scientificName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get habitat => $composableBuilder(
    column: $table.habitat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get conservationStatus => $composableBuilder(
    column: $table.conservationStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AnimalEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $AnimalEntriesTable> {
  $$AnimalEntriesTableOrderingComposer({
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

  ColumnOrderings<String> get commonName => $composableBuilder(
    column: $table.commonName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scientificName => $composableBuilder(
    column: $table.scientificName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get habitat => $composableBuilder(
    column: $table.habitat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get conservationStatus => $composableBuilder(
    column: $table.conservationStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AnimalEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AnimalEntriesTable> {
  $$AnimalEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get commonName => $composableBuilder(
    column: $table.commonName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get scientificName => $composableBuilder(
    column: $table.scientificName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get habitat =>
      $composableBuilder(column: $table.habitat, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get conservationStatus => $composableBuilder(
    column: $table.conservationStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AnimalEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AnimalEntriesTable,
          AnimalEntry,
          $$AnimalEntriesTableFilterComposer,
          $$AnimalEntriesTableOrderingComposer,
          $$AnimalEntriesTableAnnotationComposer,
          $$AnimalEntriesTableCreateCompanionBuilder,
          $$AnimalEntriesTableUpdateCompanionBuilder,
          (
            AnimalEntry,
            BaseReferences<_$AppDatabase, $AnimalEntriesTable, AnimalEntry>,
          ),
          AnimalEntry,
          PrefetchHooks Function()
        > {
  $$AnimalEntriesTableTableManager(_$AppDatabase db, $AnimalEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AnimalEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AnimalEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AnimalEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> commonName = const Value.absent(),
                Value<String> scientificName = const Value.absent(),
                Value<String> habitat = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<String> conservationStatus = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AnimalEntriesCompanion(
                id: id,
                commonName: commonName,
                scientificName: scientificName,
                habitat: habitat,
                quantity: quantity,
                conservationStatus: conservationStatus,
                notes: notes,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String commonName,
                required String scientificName,
                required String habitat,
                required int quantity,
                required String conservationStatus,
                Value<String> notes = const Value.absent(),
                required DateTime updatedAt,
              }) => AnimalEntriesCompanion.insert(
                id: id,
                commonName: commonName,
                scientificName: scientificName,
                habitat: habitat,
                quantity: quantity,
                conservationStatus: conservationStatus,
                notes: notes,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AnimalEntriesTable, AnimalEntry>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $AnimalEntriesTable,
                    AnimalEntry
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AnimalEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AnimalEntriesTable,
      AnimalEntry,
      $$AnimalEntriesTableFilterComposer,
      $$AnimalEntriesTableOrderingComposer,
      $$AnimalEntriesTableAnnotationComposer,
      $$AnimalEntriesTableCreateCompanionBuilder,
      $$AnimalEntriesTableUpdateCompanionBuilder,
      (
        AnimalEntry,
        BaseReferences<_$AppDatabase, $AnimalEntriesTable, AnimalEntry>,
      ),
      AnimalEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AnimalEntriesTableTableManager get animalEntries =>
      $$AnimalEntriesTableTableManager(_db, _db.animalEntries);
}
