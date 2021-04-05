import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:political_cartoon_repository/src/firestore/models/models.dart';

class PoliticalCartoonEntity extends Equatable {
  PoliticalCartoonEntity(
      {required this.id,
      required this.author,
      required this.date,
      required this.description,
      required this.unitId,
      required this.downloadUrl});
  final String id;
  final Timestamp date;
  final String author;
  final String description;
  final UnitId unitId;
  final String downloadUrl;

  @override
  List<Object?> get props =>
      [id, date, author, description, unitId, downloadUrl];

  @override
  String toString() {
    return 'PoliticalCartoonEntity { id: $id, date: $date, author: $author, description: $description, unitId: $unitId, downLoadUrl: $downloadUrl }';
  }

  static PoliticalCartoonEntity fromJson(Map<String, Object> json) {
    return PoliticalCartoonEntity(
      id: json['id'] as String,
      date: json['date'] as Timestamp,
      author: json['author'] as String,
      description: json['description'] as String,
      unitId: UnitId.values[json['unitId'] as int],
      downloadUrl: json['downloadUrl'] as String,
    );
  }

  static PoliticalCartoonEntity fromSnapshot(DocumentSnapshot snap) {
    Map<String, dynamic> data = snap.data()!;
    return PoliticalCartoonEntity(
        id: snap.id,
        date: data['date'] as Timestamp,
        author: data['author'] as String,
        description: data['description'] as String,
        unitId: UnitId.values[data['unitId'] as int],
        downloadUrl: data['downloadUrl'] as String);
  }

  Map<String, Object?> toDocument() {
    return {
      'date': date,
      'author': author,
      'description': description,
      'unitId': unitId.index,
      'downloadUrl': downloadUrl,
    };
  }
}
