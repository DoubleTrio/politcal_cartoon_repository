import 'dart:async';

import 'models/models.dart';

abstract class PoliticalCartoonRepository {
  Future<void> addNewPoliticalCartoon(PoliticalCartoon cartoon);

  Future<void> deletePoliticalCartoon(PoliticalCartoon cartoon);

  Future<List<PoliticalCartoon>> politicalCartoons(
      {required SortByMode sortByMode,
      required ImageType imageType,
      required Tag tag});

  Future<List<PoliticalCartoon>> loadMorePoliticalCartoons(
      {required SortByMode sortByMode,
      required ImageType imageType,
      required Tag tag});

  Future<void> updatePoliticalCartoon(PoliticalCartoon cartoon);

  Future<PoliticalCartoon> getPoliticalCartoonById(String id);

  Stream<PoliticalCartoon> getLatestPoliticalCartoon();
}
