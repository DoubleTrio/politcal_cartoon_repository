import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:political_cartoon_repository/src/firestore/models/models.dart';

import 'entities/entities.dart';
import 'models/models.dart';
import 'political_cartoon_repository.dart';

class FirestorePoliticalCartoonRepository
    implements PoliticalCartoonRepository {
  FirestorePoliticalCartoonRepository(
      {CollectionReference? collectionReference, TimeConverter? timeConverter})
      : _collectionReference = collectionReference ??
            FirebaseFirestore.instance.collection('cartoons'),
        _timeConverter = timeConverter ?? DefaultTimeAgo();

  final CollectionReference _collectionReference;
  final TimeConverter _timeConverter;
  List<DocumentSnapshot> docList = [];

  @override
  Future<void> addNewPoliticalCartoon(PoliticalCartoon cartoon) {
    return _collectionReference.add(cartoon.toEntity().toDocument());
  }

  @override
  Stream<List<PoliticalCartoon>> politicalCartoons() {
    return _collectionReference
        .orderBy('date', descending: true)
        // .where('published',
        // isGreaterThan: Timestamp.fromMicrosecondsSinceEpoch(
        //     DateTime(1999).millisecondsSinceEpoch))
        // .startAfterDocument(docList.length == 0 ? [] : docList.last)
        .limit(10)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        docList.add(doc);
        return PoliticalCartoon.fromEntity(
            PoliticalCartoonEntity.fromSnapshot(doc), _timeConverter);
      }).toList();
    });
  }

  @override
  Future<void> deletePoliticalCartoon(PoliticalCartoon cartoon) {
    return _collectionReference.firestore.doc(cartoon.id).delete();
  }

  @override
  Future<void> updatePoliticalCartoon(PoliticalCartoon updatedCartoon) {
    return _collectionReference.firestore
        .doc(updatedCartoon.id)
        .update(updatedCartoon.toEntity().toDocument());
  }

  @override
  Future<PoliticalCartoon> getPoliticalCartoonById(String id) {
    return _collectionReference.doc(id).get().then((value) =>
        PoliticalCartoon.fromEntity(
            PoliticalCartoonEntity.fromSnapshot(value), _timeConverter));
  }

  @override
  Stream<PoliticalCartoon> getLatestPoliticalCartoon() {
    return _collectionReference
        .orderBy('date', descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => PoliticalCartoon.fromEntity(
              PoliticalCartoonEntity.fromSnapshot(doc), _timeConverter))
          .toList()
          .first;
    });
  }
}
