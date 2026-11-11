import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../domain/animal.dart';

extension HabitatUi on Habitat {
  String get label => switch (this) {
    Habitat.terrestre => 'Terrestre',
    Habitat.acuatico => 'Acuático',
    Habitat.aviario => 'Aviario',
    Habitat.humedal => 'Humedal',
  };

  IconData get icon => switch (this) {
    Habitat.terrestre => Icons.landscape_rounded,
    Habitat.acuatico => Icons.water_rounded,
    Habitat.aviario => Icons.air_rounded,
    Habitat.humedal => Icons.grass_rounded,
  };

  Color get color => switch (this) {
    Habitat.terrestre => const Color(0xFF9A672E),
    Habitat.acuatico => AppColors.water,
    Habitat.aviario => const Color(0xFF6A5A9C),
    Habitat.humedal => AppColors.leaf,
  };
}

extension ConservationStatusUi on ConservationStatus {
  String get label => switch (this) {
    ConservationStatus.preocupacionMenor => 'Preocupación menor',
    ConservationStatus.casiAmenazado => 'Casi amenazado',
    ConservationStatus.vulnerable => 'Vulnerable',
    ConservationStatus.enPeligro => 'En peligro',
    ConservationStatus.critico => 'Crítico',
  };

  Color get color => switch (this) {
    ConservationStatus.preocupacionMenor => AppColors.leaf,
    ConservationStatus.casiAmenazado => const Color(0xFF8A7423),
    ConservationStatus.vulnerable => AppColors.amber,
    ConservationStatus.enPeligro => const Color(0xFFC35A2D),
    ConservationStatus.critico => const Color(0xFFA62E35),
  };
}
