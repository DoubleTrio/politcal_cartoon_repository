import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class MockPoliticalCartoonEntity extends Mock implements PoliticalCartoonEntity {}


void main() {
  late PoliticalCartoon politicalCartoon;

  String id = '1';
  String image = 'url-image';
  String author = 'Bob';
  String description = 'A very good description';

  group('Political Cartoon', () {
    setUpAll(() {
      politicalCartoon = PoliticalCartoon(id: id, image: image, author: author, description: description);
    });

    test('date stays the same while converting political cartoon to entity', () {
      var entity = politicalCartoon.toEntity();
      expect(entity.date, politicalCartoon.date);
    });

    test('conversion from political cartoon model to entity and entity to model works', () {
      var cartoon = PoliticalCartoon.fromEntity(politicalCartoon.toEntity());
      expect(cartoon, politicalCartoon);
    });

    test('fromJson method works as intended', () {
      Map<String, Object> data = {
        'id': id,
        'image': image,
        'date': politicalCartoon.date,
        'author': author,
        'description': description,
      };
      expect(PoliticalCartoonEntity.fromJson(data), equals(politicalCartoon.toEntity()));
    });

    test('fromSnapshot works as intended', () {
      // TODO implement fromSnapshot
    });
  });
}

