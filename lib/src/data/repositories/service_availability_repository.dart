import 'dart:developer';

import 'package:multibook/src/data/data_sources/authentication_data_source.dart';
import 'package:multibook/src/data/data_sources/firestore_data_source.dart';
import 'package:multibook/src/data/models/firestore_document_write.dart';
import 'package:multibook/src/data/models/service_availability_block_model.dart';
import 'package:injectable/injectable.dart';

class ServiceAvailabilityException implements Exception {
  const ServiceAvailabilityException(this.message);

  final String message;
}

@lazySingleton
class ServiceAvailabilityRepository {
  ServiceAvailabilityRepository(this._auth, this._firestore);

  static const _collection = 'service_availability_blocks';

  final AuthenticationDataSource _auth;
  final FirestoreDataSource _firestore;

  Future<List<ServiceAvailabilityBlockModel>> getBlocks({
    required String businessId,
  }) async {
    final ownerId = _auth.currentUser?.uid;
    if (ownerId == null) {
      throw const ServiceAvailabilityException(
        'You need to sign in to view availability.',
      );
    }
    final documents = await _firestore.getDocumentsWhere(
      collection: _collection,
      field: 'businessId',
      value: businessId,
    );
    return documents
        .where((document) => document['businessOwnerId'] == ownerId)
        .map(_fromDocument)
        .toList();
  }

  Future<Set<int>> getBlockedSlotStarts({
    required String businessId,
    required String providerId,
    required DateTime date,
  }) async {
    try {
      final dateKey = _dateKey(date);
      final documents = await _firestore.getDocumentsWhere(
        collection: _collection,
        field: 'businessId',
        value: businessId,
      );
      return documents
          .where(
            (document) =>
                document['providerId'] == providerId &&
                document['dateKey'] == dateKey,
          )
          .map((document) => (document['startMinutes'] as num?)?.toInt() ?? 0)
          .toSet();
    } catch (error, stackTrace) {
      log(
        'Could not load manually blocked appointment slots.',
        name: 'ServiceAvailabilityRepository',
        error: error,
        stackTrace: stackTrace,
      );
      throw const ServiceAvailabilityException(
        'We could not load availability. Please try again.',
      );
    }
  }

  Future<void> blockSlot({
    required String businessId,
    required String providerId,
    required DateTime date,
    required int startMinutes,
  }) async {
    final ownerId = _auth.currentUser?.uid;
    if (ownerId == null) {
      throw const ServiceAvailabilityException(
        'You need to sign in to block availability.',
      );
    }
    final dateKey = _dateKey(date);
    final id = _blockId(
      businessId: businessId,
      providerId: providerId,
      dateKey: dateKey,
      startMinutes: startMinutes,
    );
    final didBlock = await _firestore.createDocumentsIfAbsent(
      documentsToCheck: [
        FirestoreDocumentWrite(
          collection: _collection,
          documentId: id,
          data: const {},
        ),
      ],
      documentsToCreate: [
        FirestoreDocumentWrite(
          collection: _collection,
          documentId: id,
          data: {
            'id': id,
            'businessId': businessId,
            'businessOwnerId': ownerId,
            'providerId': providerId,
            'dateKey': dateKey,
            'startMinutes': startMinutes,
            'createdAt': _firestore.serverTimestamp,
          },
        ),
      ],
    );
    if (!didBlock) {
      throw const ServiceAvailabilityException('This slot is already blocked.');
    }
  }

  Future<void> unblockSlot({required String blockId}) =>
      _firestore.deleteDocument(collection: _collection, documentId: blockId);

  ServiceAvailabilityBlockModel _fromDocument(Map<String, dynamic> document) =>
      ServiceAvailabilityBlockModel(
        id: document['id'] as String? ?? '',
        businessId: document['businessId'] as String? ?? '',
        providerId: document['providerId'] as String? ?? '',
        dateKey: document['dateKey'] as String? ?? '',
        startMinutes: (document['startMinutes'] as num?)?.toInt() ?? 0,
      );

  static String _dateKey(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  static String _blockId({
    required String businessId,
    required String providerId,
    required String dateKey,
    required int startMinutes,
  }) => '$businessId-$providerId-$dateKey-$startMinutes';
}
