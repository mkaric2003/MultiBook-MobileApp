import 'dart:developer';

import 'package:aquabook/src/data/data_sources/authentication_data_source.dart';
import 'package:aquabook/src/data/data_sources/firestore_data_source.dart';
import 'package:aquabook/src/data/enums/support_ticket_category.dart';
import 'package:aquabook/src/data/enums/support_ticket_status.dart';
import 'package:aquabook/src/data/models/support_ticket_model.dart';
import 'package:aquabook/src/data/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

class SupportTicketException implements Exception {
  const SupportTicketException(this.message);

  final String message;
}

@lazySingleton
class SupportTicketRepository {
  SupportTicketRepository(this._auth, this._firestore, this._userRepository);

  static const _collection = 'support_tickets';

  final AuthenticationDataSource _auth;
  final FirestoreDataSource _firestore;
  final UserRepository _userRepository;

  Stream<List<SupportTicketModel>> watchMyTickets() {
    final customerId = _auth.currentUser?.uid;
    if (customerId == null) return Stream.value(const []);
    return _firestore
        .watchDocumentsWhere(
          collection: _collection,
          field: 'customerId',
          value: customerId,
          orderBy: 'createdAt',
          descending: true,
        )
        .map(
          (tickets) => tickets
              .map(
                (ticket) => SupportTicketModelMapper.fromMap(
                  _normalizeTicketData(ticket),
                ),
              )
              .toList(),
        );
  }

  Future<void> createTicket({
    required SupportTicketCategory category,
    required String subject,
    required String message,
  }) async {
    final customerId = _auth.currentUser?.uid;
    final user = await _userRepository.getCurrentUser();
    if (customerId == null || user == null) {
      throw const SupportTicketException('Unable to identify the customer.');
    }

    try {
      final ticketId = _firestore.createDocumentId(collection: _collection);
      await _firestore.setDocument(
        collection: _collection,
        documentId: ticketId,
        data: {
          'id': ticketId,
          'customerId': customerId,
          'customerName': user.fullName,
          'customerEmail': user.email,
          'category': category.name,
          'status': SupportTicketStatus.open.name,
          'subject': subject.trim(),
          'message': message.trim(),
          'createdAt': _firestore.serverTimestamp,
          'updatedAt': _firestore.serverTimestamp,
        },
      );
    } catch (error, stackTrace) {
      log(
        'Could not create support ticket.',
        name: 'SupportTicketRepository',
        error: error,
        stackTrace: stackTrace,
      );
      throw const SupportTicketException('Unable to send the support request.');
    }
  }

  Map<String, dynamic> _normalizeTicketData(Map<String, dynamic> ticket) {
    final normalized = Map<String, dynamic>.from(ticket);
    for (final field in const ['createdAt', 'updatedAt']) {
      final value = normalized[field];
      if (value is Timestamp) {
        normalized[field] = value.millisecondsSinceEpoch;
      }
    }
    return normalized;
  }
}
