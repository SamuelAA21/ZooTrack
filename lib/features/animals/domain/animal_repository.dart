import 'animal.dart';

abstract interface class AnimalRepository {
  Stream<List<Animal>> watchAll();

  Future<void> seedDemoData();

  Future<void> save(Animal animal);

  Future<void> delete(int id);
}
