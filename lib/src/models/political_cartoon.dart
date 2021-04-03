import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:political_cartoon_repository/src/entities/entities.dart';

import 'models.dart';

class PoliticalCartoon extends Equatable {
  PoliticalCartoon({
    required this.id,
    required this.image,
    Timestamp? date,
    required this.author,
    required this.description,
    required this.unitId,
  })   : this.date = date ?? Timestamp.now(),
        this.unitName = PoliticalCartoon.getUnitName(unitId);

  final String id;
  final String image;
  final Timestamp date;
  final String author;
  final String description;
  final UnitId unitId;
  final String unitName;

  @override
  List<Object?> get props =>
      [id, image, date, author, description, unitId, unitName];

  @override
  String toString() {
    return 'PoliticalCartoon { id: $id, image: $image, date: $date, author: $author, description: $description, unitId: $unitId, unitName $unitName }';
  }

  PoliticalCartoonEntity toEntity() {
    return PoliticalCartoonEntity(
        id: id,
        image: image,
        date: date,
        author: author,
        description: description,
        unitId: unitId);
  }

  static String getUnitName(UnitId unitId) {
    var id = unitId.index;
    var map = {
      1: 'The New World',
      2: 'European Colonization',
      3: 'The American Revolution',
      4: 'Modern American Democracy',
      5: 'Civil War and Reconstruction',
      6: 'The Industrial Revolution',
      7: 'The Early 20th Century',
      8: 'The Cold War',
      9: 'Modern America'
    };
    return map[id] ?? 'Unit does not exist';
  }

  static PoliticalCartoon fromEntity(PoliticalCartoonEntity entity) {
    return PoliticalCartoon(
      id: entity.id,
      image: entity.image,
      date: entity.date,
      author: entity.author,
      description: entity.description,
      unitId: entity.unitId,
    );
  }
}
