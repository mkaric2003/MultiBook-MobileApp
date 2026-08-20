import 'package:aquabook/src/data/data_cursor.dart';
import 'package:aquabook/src/data/models/firestore_document_write.dart';
import 'package:aquabook/src/data/models/firestore_document_path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

abstract class FirestoreDataSource {
  Object get serverTimestamp;

  String createDocumentId({required String collection});

  Future<bool> hasDocumentWhere({
    required String collection,
    required String field,
    required Object value,
  });

  Future<Map<String, dynamic>?> getFirstDocumentWhere({
    required String collection,
    required String field,
    required Object value,
  });

  Future<List<Map<String, dynamic>>> getDocumentsWhere({
    required String collection,
    required String field,
    required Object value,
  });

  Future<List<Map<String, dynamic>>> getDocuments({required String collection});

  Future<List<Map<String, dynamic>>> getDocumentsOrdered({
    required String collection,
    required String orderBy,
    bool descending = false,
  });

  Future<List<Map<String, dynamic>>> getDocumentsWhereArrayContains({
    required String collection,
    required String field,
    required Object value,
  });

  Future<List<Map<String, dynamic>>> getDocumentsWherePrefix({
    required String collection,
    required String equalityField,
    required Object equalityValue,
    required String prefixField,
    required String prefix,
  });

  DataCursor<T> createCursorWhere<T>({
    required String collection,
    required String field,
    required Object value,
    required int pageSize,
    required List<T> Function(List<Map<String, dynamic>> documents)
    listSerializer,
  });

  DataCursor<T> createCursorWhereAll<T>({
    required String collection,
    required Map<String, Object> filters,
    required int pageSize,
    required List<T> Function(List<Map<String, dynamic>> documents)
    listSerializer,
  });

  Future<Map<String, dynamic>?> getDocument({
    required String collection,
    required String documentId,
  });

  Future<void> setDocument({
    required String collection,
    required String documentId,
    required Map<String, Object?> data,
    bool merge = false,
  });

  /// Atomically creates [documentsToCreate] only when every lock document is
  /// still absent. Returns false when a concurrent write has claimed a lock.
  Future<bool> createDocumentsIfAbsent({
    required List<FirestoreDocumentWrite> documentsToCheck,
    required List<FirestoreDocumentWrite> documentsToCreate,
    List<FirestoreDocumentWrite> documentsToUpdate = const [],
    List<FirestoreDocumentPath> documentsToDelete = const [],
  });

  Future<void> updateDocument({
    required String collection,
    required String documentId,
    required Map<String, Object?> data,
  });

  Future<void> deleteDocument({
    required String collection,
    required String documentId,
  });
}

@LazySingleton(as: FirestoreDataSource)
class FirestoreDataSourceImpl implements FirestoreDataSource {
  FirestoreDataSourceImpl(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Object get serverTimestamp => FieldValue.serverTimestamp();

  @override
  String createDocumentId({required String collection}) =>
      _firestore.collection(collection).doc().id;

  @override
  Future<bool> hasDocumentWhere({
    required String collection,
    required String field,
    required Object value,
  }) async {
    final query = await _firestore
        .collection(collection)
        .where(field, isEqualTo: value)
        .limit(1)
        .get();
    return query.docs.isNotEmpty;
  }

  @override
  Future<Map<String, dynamic>?> getFirstDocumentWhere({
    required String collection,
    required String field,
    required Object value,
  }) async {
    final query = await _firestore
        .collection(collection)
        .where(field, isEqualTo: value)
        .limit(1)
        .get();
    return query.docs.isEmpty ? null : query.docs.first.data();
  }

  @override
  Future<List<Map<String, dynamic>>> getDocumentsWhere({
    required String collection,
    required String field,
    required Object value,
  }) async {
    final query = await _firestore
        .collection(collection)
        .where(field, isEqualTo: value)
        .get();
    return query.docs.map((document) => document.data()).toList();
  }

  @override
  Future<List<Map<String, dynamic>>> getDocuments({
    required String collection,
  }) async {
    final query = await _firestore.collection(collection).get();
    return query.docs.map((document) => document.data()).toList();
  }

  @override
  Future<List<Map<String, dynamic>>> getDocumentsOrdered({
    required String collection,
    required String orderBy,
    bool descending = false,
  }) async {
    final query = await _firestore
        .collection(collection)
        .orderBy(orderBy, descending: descending)
        .get();
    return query.docs.map((document) => document.data()).toList();
  }

  @override
  Future<List<Map<String, dynamic>>> getDocumentsWhereArrayContains({
    required String collection,
    required String field,
    required Object value,
  }) async {
    final query = await _firestore
        .collection(collection)
        .where(field, arrayContains: value)
        .get();
    return query.docs.map((document) => document.data()).toList();
  }

  @override
  Future<List<Map<String, dynamic>>> getDocumentsWherePrefix({
    required String collection,
    required String equalityField,
    required Object equalityValue,
    required String prefixField,
    required String prefix,
  }) async {
    final query = await _firestore
        .collection(collection)
        .where(equalityField, isEqualTo: equalityValue)
        .orderBy(prefixField)
        .startAt([prefix])
        .endAt(['$prefix\uf8ff'])
        .get();
    return query.docs.map((document) => document.data()).toList();
  }

  @override
  DataCursor<T> createCursorWhere<T>({
    required String collection,
    required String field,
    required Object value,
    required int pageSize,
    required List<T> Function(List<Map<String, dynamic>> documents)
    listSerializer,
  }) {
    final query = _firestore
        .collection(collection)
        .where(field, isEqualTo: value)
        .limit(pageSize);
    return DataCursor<T>(query, listSerializer, pageSize: pageSize);
  }

  @override
  DataCursor<T> createCursorWhereAll<T>({
    required String collection,
    required Map<String, Object> filters,
    required int pageSize,
    required List<T> Function(List<Map<String, dynamic>> documents)
    listSerializer,
  }) {
    Query<Map<String, dynamic>> query = _firestore.collection(collection);
    for (final filter in filters.entries) {
      query = query.where(filter.key, isEqualTo: filter.value);
    }

    return DataCursor<T>(
      query.limit(pageSize),
      listSerializer,
      pageSize: pageSize,
    );
  }

  @override
  Future<Map<String, dynamic>?> getDocument({
    required String collection,
    required String documentId,
  }) async {
    final document = await _firestore
        .collection(collection)
        .doc(documentId)
        .get();
    return document.data();
  }

  @override
  Future<void> setDocument({
    required String collection,
    required String documentId,
    required Map<String, Object?> data,
    bool merge = false,
  }) => _firestore
      .collection(collection)
      .doc(documentId)
      .set(data, SetOptions(merge: merge));

  @override
  Future<bool> createDocumentsIfAbsent({
    required List<FirestoreDocumentWrite> documentsToCheck,
    required List<FirestoreDocumentWrite> documentsToCreate,
    List<FirestoreDocumentWrite> documentsToUpdate = const [],
    List<FirestoreDocumentPath> documentsToDelete = const [],
  }) async {
    if (documentsToCheck.isEmpty) return true;

    return _firestore.runTransaction((transaction) async {
      final references = documentsToCheck
          .map(
            (document) => _firestore
                .collection(document.collection)
                .doc(document.documentId),
          )
          .toList();
      final snapshots = await Future.wait(references.map(transaction.get));
      if (snapshots.any((snapshot) => snapshot.exists)) return false;

      final deleteReferences = documentsToDelete
          .map(
            (document) => _firestore
                .collection(document.collection)
                .doc(document.documentId),
          )
          .toList();
      final deleteSnapshots = await Future.wait(
        deleteReferences.map(transaction.get),
      );

      for (final document in documentsToCreate) {
        transaction.set(
          _firestore.collection(document.collection).doc(document.documentId),
          document.data,
        );
      }
      for (final document in documentsToUpdate) {
        transaction.update(
          _firestore.collection(document.collection).doc(document.documentId),
          document.data,
        );
      }
      for (var index = 0; index < deleteReferences.length; index++) {
        if (deleteSnapshots[index].exists) {
          transaction.delete(deleteReferences[index]);
        }
      }
      return true;
    });
  }

  @override
  Future<void> updateDocument({
    required String collection,
    required String documentId,
    required Map<String, Object?> data,
  }) => _firestore.collection(collection).doc(documentId).update(data);

  @override
  Future<void> deleteDocument({
    required String collection,
    required String documentId,
  }) => _firestore.collection(collection).doc(documentId).delete();
}
