import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:political_cartoon_repository/src/firestore/models/models.dart';

import 'entities/entities.dart';
import 'models/models.dart';
import 'political_cartoon_repository.dart';

final _defaultCollection = FirebaseFirestore.instance.collection('cartoons');

class _QueryCreator {
  Query createQuery(CollectionReference reference, SortByMode sortByMode,
      ImageType imageType, Tag tag) {
    final fieldName = sortByMode.query.fieldName;
    final descending = sortByMode.query.descending;
    if (imageType != ImageType.all && tag != Tag.all) {
      return reference
          .orderBy(fieldName, descending: descending)
          .where('tags', arrayContains: tag.index)
          .where('type', isEqualTo: imageType.docType);
    } else if (imageType != ImageType.all) {
      return reference
          .orderBy(fieldName, descending: descending)
          .where('type', isEqualTo: imageType.docType);
    } else if (tag != Tag.all) {
      return reference
          .orderBy(fieldName, descending: descending)
          .where('tags', arrayContains: tag.index);
    }
    return reference.orderBy(fieldName, descending: descending);
  }
}

class FirestorePoliticalCartoonRepository
    implements PoliticalCartoonRepository {
  FirestorePoliticalCartoonRepository({
    CollectionReference? collectionReference
  }) :_collectionReference = collectionReference ?? _defaultCollection;

  final CollectionReference _collectionReference;

  List<DocumentSnapshot> docList = [];
  final _QueryCreator _queryCreator = _QueryCreator();

  @override
  Future<void> addNewPoliticalCartoon(PoliticalCartoon cartoon) {
    return _collectionReference.add(cartoon.toEntity().toDocument());
  }

  @override
  Future<List<PoliticalCartoon>> politicalCartoons({
    required SortByMode sortByMode,
    required ImageType imageType,
    required Tag tag,
    int limit = 15
  }) async {
    docList = [];
    final query = _queryCreator.createQuery(
      _collectionReference, sortByMode, imageType, tag
    );

    final snapshots = await query.limit(limit).get();
    final docs = snapshots.docs;
    docList = List.of(docList)..addAll(docs);
    return docs.map((DocumentSnapshot doc) =>
      PoliticalCartoon.fromEntity(
        PoliticalCartoonEntity.fromSnapshot(doc)
      )).toList();
  }

  @override
  Future<List<PoliticalCartoon>> loadMorePoliticalCartoons({
    required SortByMode sortByMode,
    required ImageType imageType,
    required Tag tag,
    int limit = 15
    }) async {
    final query = _queryCreator.createQuery(
      _collectionReference, sortByMode, imageType, tag);
    final snapshots = await query
      .startAfterDocument(docList[docList.length - 1])
      .limit(limit)
      .get();
    final docs = snapshots.docs;

    docList = [...docList, ...docs];

    return docs
      .map((DocumentSnapshot doc) => PoliticalCartoon.fromEntity(
        PoliticalCartoonEntity.fromSnapshot(doc)))
      .toList();
  }

  @override
  Future<void> deletePoliticalCartoon(PoliticalCartoon cartoon) {
    return _collectionReference.firestore.doc(cartoon.id).delete();
  }

  @override
  Future<void> updatePoliticalCartoon(PoliticalCartoon updatedCartoon) {
    return _collectionReference.firestore
      .doc(updatedCartoon.id)
      .update(updatedCartoon.toEntity().toDocument()
    );
  }

  @override
  Future<void> likeCartoon(String id) {
    return _collectionReference.firestore
      .doc(id)
      .update(<String, int>{ 'likes': 0 });
  }

  @override
  Future<void> unlikeCartoon(String id) {
    return _collectionReference.firestore
      .doc(id)
      .update(<String, int>{ 'likes': 0 });
  }
  
  
  @override
  Future<PoliticalCartoon> getPoliticalCartoonById(String id) {
    return _collectionReference.doc(id).get().then((value) =>
      PoliticalCartoon.fromEntity(
        PoliticalCartoonEntity.fromSnapshot(value),
      ),
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
