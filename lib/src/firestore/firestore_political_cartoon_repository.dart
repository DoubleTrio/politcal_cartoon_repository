import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'entities/entities.dart';
import 'models/models.dart';
import 'political_cartoon_repository.dart';

class FirestorePoliticalCartoonRepository
    implements PoliticalCartoonRepository {
  CollectionReference cartoonCollection =
      FirebaseFirestore.instance.collection('cartoons');

  @override
  Future<void> addNewPoliticalCartoon(PoliticalCartoon cartoon) {
    return cartoonCollection.add(cartoon.toEntity().toDocument());
  }

  @override
  Stream<List<PoliticalCartoon>> politicalCartoons() {
    return cartoonCollection.limit(10).snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => PoliticalCartoon.fromEntity(
              PoliticalCartoonEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> deletePoliticalCartoon(PoliticalCartoon cartoon) {
    return cartoonCollection.firestore.doc(cartoon.id).delete();
  }

  @override
  Future<void> updatePoliticalCartoon(PoliticalCartoon updatedCartoon) {
    return cartoonCollection.firestore
        .doc(updatedCartoon.id)
        .update(updatedCartoon.toEntity().toDocument());
  }

  @override
  Future<PoliticalCartoon> getPoliticalCartoonById(String id) {
    return cartoonCollection.doc(id).get().then((value) =>
        PoliticalCartoon.fromEntity(
            PoliticalCartoonEntity.fromSnapshot(value)));
  }

  @override
  Stream<PoliticalCartoon> getLatestPoliticalCartoon() {
    return cartoonCollection
        .orderBy('date', descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => PoliticalCartoon.fromEntity(
              PoliticalCartoonEntity.fromSnapshot(doc)))
          .toList()
          .first;
    });
  }
}
