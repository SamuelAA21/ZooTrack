import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zootrack/core/theme/app_theme.dart';
import 'package:zootrack/features/animals/domain/animal.dart';
import 'package:zootrack/features/animals/domain/animal_repository.dart';
import 'package:zootrack/features/animals/presentation/animals_controller.dart';
import 'package:zootrack/features/animals/presentation/animals_page.dart';

void main() {
  testWidgets('inventario se adapta a escritorio sin desbordarse', (
    tester,
  ) async {
    await _renderAt(tester, const Size(1440, 900));
    expect(find.text('Inventario'), findsOneWidget);
    expect(find.text('El inventario,\nclaro y al día.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('inventario se adapta a móvil sin desbordarse', (tester) async {
    await _renderAt(tester, const Size(390, 844));
    expect(find.text('Inventario'), findsOneWidget);
    expect(find.text('Registrar especie'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

Future<void> _renderAt(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  final controller = AnimalsController(_PreviewAnimalRepository());
  await controller.initialize();
  addTearDown(controller.dispose);

  await tester.pumpWidget(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: AnimalsPage(controller: controller),
    ),
  );
  await tester.pump();
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 120));
}

class _PreviewAnimalRepository implements AnimalRepository {
  final _animals = [
    Animal(
      id: 1,
      commonName: 'Oso de anteojos',
      scientificName: 'Tremarctos ornatus',
      habitat: Habitat.terrestre,
      quantity: 2,
      status: ConservationStatus.vulnerable,
      updatedAt: DateTime(2026),
    ),
    Animal(
      id: 2,
      commonName: 'Cóndor de los Andes',
      scientificName: 'Vultur gryphus',
      habitat: Habitat.aviario,
      quantity: 3,
      status: ConservationStatus.vulnerable,
      updatedAt: DateTime(2026),
    ),
    Animal(
      id: 3,
      commonName: 'Nutria gigante',
      scientificName: 'Pteronura brasiliensis',
      habitat: Habitat.acuatico,
      quantity: 4,
      status: ConservationStatus.enPeligro,
      updatedAt: DateTime(2026),
    ),
    Animal(
      id: 4,
      commonName: 'Rana dorada',
      scientificName: 'Phyllobates terribilis',
      habitat: Habitat.humedal,
      quantity: 8,
      status: ConservationStatus.enPeligro,
      updatedAt: DateTime(2026),
    ),
    Animal(
      id: 5,
      commonName: 'Jaguar',
      scientificName: 'Panthera onca',
      habitat: Habitat.terrestre,
      quantity: 2,
      status: ConservationStatus.casiAmenazado,
      updatedAt: DateTime(2026),
    ),
  ];

  @override
  Stream<List<Animal>> watchAll() => Stream.value(_animals);

  @override
  Future<void> seedDemoData() async {}

  @override
  Future<void> delete(int id) async {}

  @override
  Future<void> save(Animal animal) async {}
}
