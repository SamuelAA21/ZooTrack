import 'dart:async';

import 'package:flutter/foundation.dart';

import '../domain/animal.dart';
import '../domain/animal_repository.dart';

class AnimalsController extends ChangeNotifier {
  AnimalsController(this._repository);

  final AnimalRepository _repository;
  StreamSubscription<List<Animal>>? _subscription;

  List<Animal> _animals = const [];
  String _search = '';
  Habitat? _habitat;
  bool _isLoading = true;
  Object? _error;

  List<Animal> get animals {
    final normalizedSearch = _search.trim().toLowerCase();
    return _animals
        .where((animal) {
          final matchesHabitat = _habitat == null || animal.habitat == _habitat;
          final matchesSearch =
              normalizedSearch.isEmpty ||
              animal.commonName.toLowerCase().contains(normalizedSearch) ||
              animal.scientificName.toLowerCase().contains(normalizedSearch);
          return matchesHabitat && matchesSearch;
        })
        .toList(growable: false);
  }

  bool get isLoading => _isLoading;
  Object? get error => _error;
  Habitat? get selectedHabitat => _habitat;
  int get speciesCount => _animals.length;
  int get specimenCount =>
      _animals.fold(0, (total, animal) => total + animal.quantity);
  int get habitatCount =>
      _animals.map((animal) => animal.habitat).toSet().length;
  bool get hasActiveFilters => _search.trim().isNotEmpty || _habitat != null;

  Future<void> initialize() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.seedDemoData();
      await _subscription?.cancel();
      _subscription = _repository.watchAll().listen(
        (animals) {
          _animals = animals;
          _isLoading = false;
          _error = null;
          notifyListeners();
        },
        onError: (Object error) {
          _isLoading = false;
          _error = error;
          notifyListeners();
        },
      );
    } catch (error) {
      _isLoading = false;
      _error = error;
      notifyListeners();
    }
  }

  void setSearch(String value) {
    _search = value;
    notifyListeners();
  }

  void setHabitat(Habitat? value) {
    _habitat = value;
    notifyListeners();
  }

  void clearFilters() {
    _search = '';
    _habitat = null;
    notifyListeners();
  }

  Future<void> save(Animal animal) => _repository.save(animal);

  Future<void> delete(Animal animal) async {
    final id = animal.id;
    if (id == null) return;
    await _repository.delete(id);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
