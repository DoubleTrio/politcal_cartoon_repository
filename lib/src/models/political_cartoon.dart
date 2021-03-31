import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:political_cartoon_repository/src/entities/entities.dart';

class PoliticalCartoon extends Equatable {
  PoliticalCartoon({ required this.id, required this.image, Timestamp? date, required this.author, required this.description})
      : this.date = date ?? Timestamp.now();

  final String id;
  final String image;
  final Timestamp date;
  final String author;
  final String description;

  @override
  List<Object?> get props => [id, image, date, author, description];

  @override
  String toString() {
    return 'PoliticalCartoon { id: $id, image: $image, date: $date, author: $author, description: $description }';
  }

  PoliticalCartoonEntity toEntity() {
    return PoliticalCartoonEntity(id: id, image: image, date: date, author: author, description: description);
  }

  static PoliticalCartoon fromEntity(PoliticalCartoonEntity entity) {
    return PoliticalCartoon(id: entity.id, image: entity.image, date: entity.date, author: entity.author, description: entity.description);
  }
}