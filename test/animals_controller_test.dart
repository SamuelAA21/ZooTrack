import 'package:flutter_test/flutter_test.dart';
import 'package:zootrack/features/animals/domain/animal.dart';
import 'package:zootrack/features/animals/domain/animal_repository.dart';
import 'package:zootrack/features/animals/presentation/animals_controller.dart';

void main() {
  final animals = [
    Animal(
      id: 1,
      commonName: 'Jaguar',
      scientificName: 'Panthera onca',
      habitat: Habitat.terrestre,
      quantity: 2,
      status: ConservationStatus.casiAmenazado,
      updatedAt: DateTime(2026),
    ),
    Animal(
      id: 2,
      commonName: 'Nutria gigante',
      scientificName: 'Pteronura brasiliensis',
      habitat: Habitat.acuatico,
      quantity: 4,
      status: ConservationStatus.enPeligro,
      updatedAt: DateTime(2026),
    ),
  ];

  test('calcula los indicadores generales', () async {
    final controller = AnimalsController(_FakeAnimalRepository(animals));

    await controller.initialize();
    await Future<void>.delayed(Duration.zero);

    expect(controller.speciesCount, 2);
    expect(controller.specimenCount, 6);
    expect(controller.habitatCount, 2);
    controller.dispose();
  });

  test('filtra por nombre científico y hábitat', () async {
    final controller = AnimalsController(_FakeAnimalRepository(animals));
    await controller.initialize();
    await Future<void>.delayed(Duration.zero);

    controller.setSearch('pteronura');
    expect(controller.animals.single.commonName, 'Nutria gigante');

    controller.setSearch('');
    controller.setHabitat(Habitat.terrestre);
    expect(controller.animals.single.commonName, 'Jaguar');
    controller.dispose();
  });
}

class _FakeAnimalRepository implements AnimalRepository {
  _FakeAnimalRepository(this.animals);

  final List<Animal> animals;

  @override
  Stream<List<Animal>> watchAll() => Stream.value(animals);

  @override
  Future<void> seedDemoData() async {}

  @override
  Future<void> delete(int id) async {}

  @override
  Future<void> save(Animal animal) async {}
}
