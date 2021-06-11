import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'models/models.dart';

abstract class PoliticalCartoonRepository {
  Future<void> addNewPoliticalCartoon(PoliticalCartoon cartoon);

  Future<void> deletePoliticalCartoon(PoliticalCartoon cartoon);

  Future<List<PoliticalCartoon>> politicalCartoons({
    required SortByMode sortByMode,
    required ImageType imageType,
    required Tag tag
  });

  Future<List<PoliticalCartoon>> loadMorePoliticalCartoons({
    required SortByMode sortByMode,
    required ImageType imageType,
    required Tag tag
  });

  Future<void> likeCartoon(String id);

  Future<void> unlikeCartoon(String id);

  Future<void> updatePoliticalCartoon(PoliticalCartoon cartoon);

  Future<PoliticalCartoon> getPoliticalCartoonById(String id);

  Stream<PoliticalCartoon> getLatestPoliticalCartoon();
}
