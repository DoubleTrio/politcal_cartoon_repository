import 'dart:async';

import 'models/models.dart';

abstract class PoliticalCartoonRepository {
  Future<void> addNewPoliticalCartoon(PoliticalCartoonEntity cartoon);

  Future<void> deletePoliticalCartoon(PoliticalCartoonEntity cartoon);

  Stream<List<PoliticalCartoonEntity>> politicalCartoons();

  Future<void> updatePoliticalCartoon(PoliticalCartoonEntity cartoon);

  Future<PoliticalCartoonEntity> getPoliticalCartoonById(String id);

  Stream<PoliticalCartoonEntity> getLatestPoliticalCartoon();
}