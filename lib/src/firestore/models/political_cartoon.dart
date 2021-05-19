import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:political_cartoon_repository/src/firestore/entities/entities.dart';
import 'package:political_cartoon_repository/src/firestore/models/models.dart';

import 'models.dart';

class PoliticalCartoon extends Equatable {
  PoliticalCartoon({
    String? id,
    Timestamp? timestamp,
    required this.tags,
    required this.author,
    required this.description,
    required this.downloadUrl,
    required this.published,
    required this.type,
  }) :
    id = id ?? '',
    timestamp = timestamp ?? Timestamp.now(),
    publishedString = DateFormat('yyyy').format(published.toDate());

  final String id;
  final Timestamp timestamp;
  final String author;
  final String description;
  final List<Tag> tags;
  final String downloadUrl;
  final Timestamp published;
  final String publishedString;
  final ImageType type;

  @override
  List<Object?> get props => [
        id,
        timestamp,
        author,
        description,
        tags,
        downloadUrl,
        published,
        publishedString,
        type
      ];

  @override
  String toString() {
    return 'PoliticalCartoon { '
      'id: $id, '
      'timestamp: $timestamp, '
      'author: $author, '
      'description: $description, '
      'tags: $tags, '
      'downloadUrl: $downloadUrl, '
      'published: $published, '
      'publishedSting: $publishedString '
    '}';
  }

  PoliticalCartoonEntity toEntity() {
    return PoliticalCartoonEntity(
      id: id,
      timestamp: timestamp,
      author: author,
      description: description,
      tags: tags,
      downloadUrl: downloadUrl,
      published: published,
      type: type
    );
  }

  static PoliticalCartoon fromEntity(PoliticalCartoonEntity entity) {
    return PoliticalCartoon(
      id: entity.id,
      timestamp: entity.timestamp,
      author: entity.author,
      description: entity.description.replaceAll('\\n', '\n'),
      tags: entity.tags,
      downloadUrl: entity.downloadUrl,
      published: entity.published,
      type: entity.type,
    );
  }

  PoliticalCartoon copyWith({
    String? id,
    Timestamp? timestamp,
    List<Tag>? tags,
    String? author,
    String? description,
    String? downloadUrl,
    Timestamp? published,
    ImageType? type,
  }) {
    return PoliticalCartoon(
      tags: tags ?? this.tags,
      author: author ?? this.author,
      description: description ?? this.description,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      published: published ?? this.published,
      type: type ?? this.type,
    );
  }
}
