import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class MockPoliticalCartoonEntity extends Mock
    implements PoliticalCartoonEntity {}

void main() {
  late PoliticalCartoon politicalCartoon;

  String id = '1';
  String downloadUrl = 'downloadUrl';
  String author = 'Bob';
  String description = 'A very good description';
  Tag tag = Tag.tag1;
  Timestamp published = Timestamp.now();
  ImageType type = ImageType.cartoon;

  group('Political Cartoon', () {
    setUpAll(() {
      politicalCartoon = PoliticalCartoon(
        id: id,
        author: author,
        description: description,
        tags: [Tag.tag1],
        downloadUrl: downloadUrl,
        published: published,
        type: ImageType.cartoon,
      );
    });

    test('date stays the same while converting political cartoon to entity',
        () {
      var entity = politicalCartoon.toEntity();
      expect(entity.date, politicalCartoon.date);
    });

    test(
        'conversion from political cartoon model to entity and entity to model works',
        () {
      var cartoon = PoliticalCartoon.fromEntity(politicalCartoon.toEntity());
      expect(cartoon, politicalCartoon);
    });

    test('fromJson method works as intended', () {
      Map<String, Object> data = {
        'id': id,
        'date': politicalCartoon.date,
        'author': author,
        'description': description,
        'tags': [tag.index],
        'downloadUrl': downloadUrl,
        'published': published,
        'type': type.imageType
      };
      expect(PoliticalCartoonEntity.fromJson(data),
          equals(politicalCartoon.toEntity()));
    });

    test('fromSnapshot works as intended', () async {});
  });
}
