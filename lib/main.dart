import 'package:flutter/material.dart';

import 'core/database/app_database.dart';
import 'core/theme/app_theme.dart';
import 'features/animals/data/drift_animal_repository.dart';
import 'features/animals/presentation/animals_controller.dart';
import 'features/animals/presentation/animals_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ZooTrackBootstrap());
}

class ZooTrackBootstrap extends StatefulWidget {
  const ZooTrackBootstrap({super.key});

  @override
  State<ZooTrackBootstrap> createState() => _ZooTrackBootstrapState();
}

class _ZooTrackBootstrapState extends State<ZooTrackBootstrap> {
  late final AppDatabase _database;
  late final AnimalsController _controller;

  @override
  void initState() {
    super.initState();
    _database = AppDatabase.defaults();
    _controller = AnimalsController(DriftAnimalRepository(_database))
      ..initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    _database.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZooTrack',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: AnimalsPage(controller: _controller),
    );
  }
}
