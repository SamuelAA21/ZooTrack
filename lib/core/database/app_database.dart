import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class AnimalEntries extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get commonName => text().withLength(min: 2, max: 80)();

  TextColumn get scientificName => text().withLength(min: 2, max: 120)();

  TextColumn get habitat => text()();

  IntColumn get quantity =>
      integer().check(const CustomExpression<bool>('quantity > 0'))();

  TextColumn get conservationStatus => text()();

  TextColumn get notes => text().withDefault(const Constant(''))();

  DateTimeColumn get updatedAt => dateTime()();
}

@DriftDatabase(tables: [AnimalEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  AppDatabase.defaults()
    : super(
        driftDatabase(
          name: 'zootrack',
          web: DriftWebOptions(
            sqlite3Wasm: Uri.parse('sqlite3.wasm'),
            driftWorker: Uri.parse('drift_worker.js'),
          ),
        ),
      );

  @override
  int get schemaVersion => 1;
}
