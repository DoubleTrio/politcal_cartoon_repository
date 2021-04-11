import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:political_cartoon_repository/src/firestore/entities/entities.dart';
import 'package:political_cartoon_repository/src/firestore/models/models.dart';

import 'models.dart';

class PoliticalCartoon extends Equatable {
  PoliticalCartoon({
    String? id,
    Timestamp? date,
    TimeConverter timeConverter = const DefaultTimeAgo(),
    required this.author,
    required this.description,
    required this.unitId,
    required this.downloadUrl,
    required this.published,
  })   : this.id = id ?? '',
        this.timeConverter = timeConverter,
        this.date = date ?? Timestamp.now(),
        this.unitName = PoliticalCartoon.getUnitName(unitId),
        this.dateString =
            timeConverter.timeAgoSinceDate(date ?? Timestamp.now()),
        this.publishedString = DateFormat("yyyy").format(published.toDate());

  final String id;
  final Timestamp date;
  final String author;
  final String description;
  final UnitId unitId;
  final String unitName;
  final String downloadUrl;
  final String dateString;
  final TimeConverter timeConverter;
  final Timestamp published;
  final String publishedString;

  @override
  List<Object?> get props => [
        id,
        date,
        author,
        description,
        unitId,
        unitName,
        downloadUrl,
        dateString,
        timeConverter,
        published,
        publishedString
      ];

  @override
  String toString() {
    return 'PoliticalCartoon { id: $id, date: $date, author: $author, description: $description, unitId: $unitId, unitName: $unitName, downloadUrl: $downloadUrl, dateString: $dateString, published: $published, publishedSting: $publishedString }';
  }

  PoliticalCartoonEntity toEntity() {
    return PoliticalCartoonEntity(
      id: id,
      date: date,
      author: author,
      description: description,
      unitId: unitId,
      downloadUrl: downloadUrl,
      published: published,
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

  static PoliticalCartoon fromEntity(
      PoliticalCartoonEntity entity, TimeConverter timeConverter) {
    return PoliticalCartoon(
      id: entity.id,
      date: entity.date,
      author: entity.author,
      description: entity.description,
      unitId: entity.unitId,
      downloadUrl: entity.downloadUrl,
      timeConverter: timeConverter,
      published: entity.published,
    );
  }
}
