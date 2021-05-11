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
    required List<Tag> tags,
    required this.author,
    required this.description,
    required this.downloadUrl,
    required this.published,
  })   : this.id = id ?? '',
        this.tags = tags,
        this.date = date ?? Timestamp.now(),
        this.publishedString = DateFormat("yyyy").format(published.toDate());

  final String id;
  final Timestamp date;
  final String author;
  final String description;
  final List<Tag> tags;
  final String downloadUrl;
  final Timestamp published;
  final String publishedString;

  @override
  List<Object?> get props => [
        id,
        date,
        author,
        description,
        tags,
        downloadUrl,
        published,
        publishedString
      ];

  @override
  String toString() {
    return 'PoliticalCartoon { id: $id, date: $date, author: $author, description: $description, tags: $tags, downloadUrl: $downloadUrl, published: $published, publishedSting: $publishedString }';
  }

  PoliticalCartoonEntity toEntity() {
    return PoliticalCartoonEntity(
      id: id,
      date: date,
      author: author,
      description: description,
      tags: tags,
      downloadUrl: downloadUrl,
      published: published,
    );
  }

  static PoliticalCartoon fromEntity(PoliticalCartoonEntity entity) {
    return PoliticalCartoon(
      id: entity.id,
      date: entity.date,
      author: entity.author,
      description: entity.description.replaceAll('\\n', '\n'),
      tags: entity.tags,
      downloadUrl: entity.downloadUrl,
      published: entity.published,
    );
  }
}
