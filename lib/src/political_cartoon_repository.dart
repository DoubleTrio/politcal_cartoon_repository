import 'dart:async';

import 'models/models.dart';

abstract class PoliticalCartoonRepository {
  Future<void> addNewPoliticalCartoon(PoliticalCartoon cartoon);

  Future<void> deletePoliticalCartoon(PoliticalCartoon cartoon);

  Stream<List<PoliticalCartoon>> politicalCartoons();

  Future<void> updatePoliticalCartoon(PoliticalCartoon cartoon);

  Future<PoliticalCartoon> getPoliticalCartoonById(String id);

  Stream<PoliticalCartoon> getLatestPoliticalCartoon();

  Future<String> getImageUrl(String uri);
}
