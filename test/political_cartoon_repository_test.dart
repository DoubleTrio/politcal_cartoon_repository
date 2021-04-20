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
  Unit unit = Unit.unit1;
  Timestamp published = Timestamp.now();

  group('Political Cartoon', () {
    setUpAll(() {
      politicalCartoon = PoliticalCartoon(
        id: id,
        author: author,
        description: description,
        unit: Unit.unit1,
        downloadUrl: downloadUrl,
        published: published,
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
        'unit': unit.index,
        'downloadUrl': downloadUrl,
        'published': published
      };
      expect(PoliticalCartoonEntity.fromJson(data),
          equals(politicalCartoon.toEntity()));
    });

    test('fromSnapshot works as intended', () async {});
  });
}
