import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:political_cartoon_repository/src/firestore/models/models.dart';
import 'package:political_cartoon_repository/src/firestore/utils/utils.dart';

class PoliticalCartoonEntity extends Equatable {
  PoliticalCartoonEntity(
      {required this.id,
      required this.author,
      required this.date,
      required this.description,
      required this.units,
      required this.downloadUrl,
      required this.published});

  final String id;
  final Timestamp date;
  final String author;
  final String description;
  final List<Unit> units;
  final String downloadUrl;
  final Timestamp published;

  @override
  List<Object?> get props =>
      [id, date, author, description, units, downloadUrl, published];

  @override
  String toString() {
    return 'PoliticalCartoonEntity { id: $id, date: $date, author: $author, description: $description, units: $units, downLoadUrl: $downloadUrl, published: $published }';
  }

  static PoliticalCartoonEntity fromJson(Map<String, Object> json) {
    return PoliticalCartoonEntity(
      id: json['id'] as String,
      date: json['date'] as Timestamp,
      author: json['author'] as String,
      description: json['description'] as String,
      units: mapUnitIdToUnits(json['units'] as List<int>),
      downloadUrl: json['downloadUrl'] as String,
      published: json['published'] as Timestamp,
    );
  }

  static PoliticalCartoonEntity fromSnapshot(DocumentSnapshot snap) {
    Map<String, dynamic> data = snap.data()!;
    return PoliticalCartoonEntity(
        id: snap.id,
        date: data['date'] as Timestamp,
        author: data['author'] as String,
        description: data['description'] as String,
        units: mapUnitIdToUnits(List<int>.from(data['units'])),
        downloadUrl: data['downloadUrl'] as String,
        published: data['published'] as Timestamp);
  }

  Map<String, Object?> toDocument() {
    return {
      'date': date,
      'author': author,
      'description': description,
      'units': mapUnitsToUnitIds(units),
      'downloadUrl': downloadUrl,
      'published': published,
    };
  }
}
