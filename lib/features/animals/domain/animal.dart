enum Habitat { terrestre, acuatico, aviario, humedal }

enum ConservationStatus {
  preocupacionMenor,
  casiAmenazado,
  vulnerable,
  enPeligro,
  critico,
}

class Animal {
  const Animal({
    this.id,
    required this.commonName,
    required this.scientificName,
    required this.habitat,
    required this.quantity,
    required this.status,
    this.notes = '',
    required this.updatedAt,
  });

  final int? id;
  final String commonName;
  final String scientificName;
  final Habitat habitat;
  final int quantity;
  final ConservationStatus status;
  final String notes;
  final DateTime updatedAt;
}
