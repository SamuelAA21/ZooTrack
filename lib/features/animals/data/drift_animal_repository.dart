import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../domain/animal.dart';
import '../domain/animal_repository.dart';

class DriftAnimalRepository implements AnimalRepository {
  DriftAnimalRepository(this._database);

  final AppDatabase _database;

  @override
  Stream<List<Animal>> watchAll() {
    final query = _database.select(_database.animalEntries)
      ..orderBy([(table) => OrderingTerm.asc(table.commonName)]);
    return query.watch().map(
      (rows) => rows.map(_toDomain).toList(growable: false),
    );
  }

  @override
  Future<void> save(Animal animal) async {
    final companion = AnimalEntriesCompanion(
      id: animal.id == null ? const Value.absent() : Value(animal.id!),
      commonName: Value(animal.commonName.trim()),
      scientificName: Value(animal.scientificName.trim()),
      habitat: Value(animal.habitat.name),
      quantity: Value(animal.quantity),
      conservationStatus: Value(animal.status.name),
      notes: Value(animal.notes.trim()),
      updatedAt: Value(animal.updatedAt),
    );

    if (animal.id == null) {
      await _database.into(_database.animalEntries).insert(companion);
      return;
    }

    await (_database.update(
      _database.animalEntries,
    )..where((table) => table.id.equals(animal.id!))).write(companion);
  }

  @override
  Future<void> delete(int id) async {
    await (_database.delete(
      _database.animalEntries,
    )..where((table) => table.id.equals(id))).go();
  }

  @override
  Future<void> seedDemoData() async {
    final existing = await (_database.select(
      _database.animalEntries,
    )..limit(1)).get();
    if (existing.isNotEmpty) return;

    final now = DateTime.now();
    final samples = <Animal>[
      Animal(
        commonName: 'Oso de anteojos',
        scientificName: 'Tremarctos ornatus',
        habitat: Habitat.terrestre,
        quantity: 2,
        status: ConservationStatus.vulnerable,
        notes: 'Pareja adulta bajo seguimiento veterinario.',
        updatedAt: now,
      ),
      Animal(
        commonName: 'Cóndor de los Andes',
        scientificName: 'Vultur gryphus',
        habitat: Habitat.aviario,
        quantity: 3,
        status: ConservationStatus.vulnerable,
        updatedAt: now,
      ),
      Animal(
        commonName: 'Nutria gigante',
        scientificName: 'Pteronura brasiliensis',
        habitat: Habitat.acuatico,
        quantity: 4,
        status: ConservationStatus.enPeligro,
        updatedAt: now,
      ),
      Animal(
        commonName: 'Rana dorada',
        scientificName: 'Phyllobates terribilis',
        habitat: Habitat.humedal,
        quantity: 8,
        status: ConservationStatus.enPeligro,
        updatedAt: now,
      ),
      Animal(
        commonName: 'Jaguar',
        scientificName: 'Panthera onca',
        habitat: Habitat.terrestre,
        quantity: 2,
        status: ConservationStatus.casiAmenazado,
        updatedAt: now,
      ),
    ];

    await _database.batch((batch) {
      batch.insertAll(
        _database.animalEntries,
        samples.map(_toCompanion).toList(growable: false),
      );
    });
  }

  Animal _toDomain(AnimalEntry row) {
    return Animal(
      id: row.id,
      commonName: row.commonName,
      scientificName: row.scientificName,
      habitat: Habitat.values.byName(row.habitat),
      quantity: row.quantity,
      status: ConservationStatus.values.byName(row.conservationStatus),
      notes: row.notes,
      updatedAt: row.updatedAt,
    );
  }

  AnimalEntriesCompanion _toCompanion(Animal animal) {
    return AnimalEntriesCompanion.insert(
      commonName: animal.commonName,
      scientificName: animal.scientificName,
      habitat: animal.habitat.name,
      quantity: animal.quantity,
      conservationStatus: animal.status.name,
      notes: Value(animal.notes),
      updatedAt: animal.updatedAt,
    );
  }
}
