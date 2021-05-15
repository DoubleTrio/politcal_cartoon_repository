import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:political_cartoon_repository/src/firestore/models/models.dart';

import 'entities/entities.dart';
import 'models/models.dart';
import 'political_cartoon_repository.dart';

class _QueryCreator {
  Query createQuery(CollectionReference reference, SortByMode sortByMode, ImageType imageType, Tag tag) {
    var fieldName = sortByMode.query.fieldName;
    var descending = sortByMode.query.descending;
    if (imageType != ImageType.all && tag != Tag.all) {
      return reference.orderBy(fieldName, descending: descending)
        .where('tags', arrayContains: tag.index)
        .where('type', isEqualTo: imageType.docType);
    } else if (imageType != ImageType.all) {
      return reference.orderBy(fieldName, descending: descending)
        .where('type', isEqualTo: imageType.docType);
    } else if (tag != Tag.all) {
      return reference.orderBy(fieldName, descending: descending)
        .where('tags', arrayContains: tag.index);
    }
    return reference.orderBy(fieldName, descending: descending);
  }
}

class FirestorePoliticalCartoonRepository
    implements PoliticalCartoonRepository {
  FirestorePoliticalCartoonRepository({CollectionReference? collectionReference})
      : _collectionReference = collectionReference ??
        FirebaseFirestore.instance.collection('cartoons');

  final CollectionReference _collectionReference;

  List<DocumentSnapshot> docList = [];
  _QueryCreator _queryCreator = _QueryCreator();

  @override
  Future<void> addNewPoliticalCartoon(PoliticalCartoon cartoon) {
    return _collectionReference.add(cartoon.toEntity().toDocument());
  }

  @override
  Stream<List<PoliticalCartoon>> politicalCartoons({
    required SortByMode sortByMode,
    required ImageType imageType,
    required Tag tag,
    int limit = 10
  }) {
    docList = [];

    Query query = _queryCreator.createQuery(_collectionReference, sortByMode, imageType, tag);

    var snapshots = query.limit(limit).snapshots();
    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        docList.add(doc);
        return PoliticalCartoon.fromEntity(
          PoliticalCartoonEntity.fromSnapshot(doc));
      }).toList();
    });
  }

  @override
  Stream<List<PoliticalCartoon>> loadMorePoliticalCartoons({
    required SortByMode sortByMode,
    required ImageType imageType,
    required Tag tag,
    int limit = 10
  }) {

    Query query = _queryCreator.createQuery(_collectionReference, sortByMode, imageType, tag);
    var snapshots = query.startAfter(docList[docList.length - 1] as dynamic).limit(limit).snapshots();
    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        docList.add(doc);
        return PoliticalCartoon.fromEntity(
            PoliticalCartoonEntity.fromSnapshot(doc));
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
        PoliticalCartoonEntity.fromSnapshot(value)
      )
    );
  }

  @override
  Stream<PoliticalCartoon> getLatestPoliticalCartoon() {
    return _collectionReference
      .orderBy('timestamp', descending: true)
      .limit(1)
      .snapshots()
      .map((snapshot) {
      return snapshot.docs
        .map((doc) => PoliticalCartoon.fromEntity(
          PoliticalCartoonEntity.fromSnapshot(doc)
        )).toList().first;
    });
  }
}
