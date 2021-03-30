import 'dart:async';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'political_cartoon_repository.dart';
import 'models/models.dart';


class FirebasePoliticalCartoonRepository implements PoliticalCartoonRepository {
  CollectionReference cartoonCollection = FirebaseFirestore.instance.collection('cartoons');

  @override
  Future<void> addNewPoliticalCartoon(PoliticalCartoonEntity cartoon) {
    return cartoonCollection.add(cartoon.toDocument());
  }

  @override
  Stream<List<PoliticalCartoonEntity>> politicalCartoons() {
  return cartoonCollection.snapshots().map((snapshot) {
    return snapshot.docs
      .map((doc) => PoliticalCartoonEntity.fromSnapshot(doc))
      .toList();
    });
  }

  @override
  Future<void> deletePoliticalCartoon(PoliticalCartoonEntity cartoon) {
    return cartoonCollection.firestore.doc(cartoon.id).delete();
  }

  @override
  Future<void> updatePoliticalCartoon(PoliticalCartoonEntity updatedCartoon) {
    return cartoonCollection.firestore
      .doc(updatedCartoon.id)
      .update(updatedCartoon.toDocument());
  }

  @override
  Future<PoliticalCartoonEntity> getPoliticalCartoonById(String id) {
    return cartoonCollection
      .doc(id)
      .get()
      .then((value) => PoliticalCartoonEntity.fromSnapshot(value));
  }
  
  @override
  Future<PoliticalCartoonEntity> getLatestPoliticalCartoon() {
    // return cartoonCollection.snapshots().last.then((value) => PoliticalCartoonEntity.fromSnapshot(value));
    throw UnimplementedError();
  }
}


    