import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:political_cartoon_repository/src/firestore/entities/entities.dart';

import 'models.dart';

class PoliticalCartoon extends Equatable {
  PoliticalCartoon({
    required this.id,
    Timestamp? date,
    required this.author,
    required this.description,
    required this.unitId,
    required this.downloadUrl,
  })   : this.date = date ?? Timestamp.now(),
        this.unitName = PoliticalCartoon.getUnitName(unitId),
        this.dateString =
            date?.toDate().toString() ?? Timestamp.now().toDate().toString();

  final String id;
  final Timestamp date;
  final String author;
  final String description;
  final UnitId unitId;
  final String unitName;
  final String downloadUrl;
  final String dateString;

  @override
  List<Object?> get props => [
        id,
        date,
        author,
        description,
        unitId,
        unitName,
        downloadUrl,
        dateString
      ];

  @override
  String toString() {
    return 'PoliticalCartoon { id: $id, date: $date, author: $author, description: $description, unitId: $unitId, unitName: $unitName, downloadUrl: $downloadUrl, dateString: $dateString }';
  }

  PoliticalCartoonEntity toEntity() {
    return PoliticalCartoonEntity(
      id: id,
      date: date,
      author: author,
      description: description,
      unitId: unitId,
      downloadUrl: downloadUrl,
    );
  }

  static String getUnitName(UnitId unitId) {
    var id = unitId.index;
    var map = {
      0: 'World History',
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
        date: entity.date,
        author: entity.author,
        description: entity.description,
        unitId: entity.unitId,
        downloadUrl: entity.downloadUrl);
  }
}
