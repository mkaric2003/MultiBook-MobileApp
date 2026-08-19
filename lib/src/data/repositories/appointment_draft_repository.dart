import 'package:aquabook/src/data/data_sources/authentication_data_source.dart';
import 'package:aquabook/src/data/data_sources/firestore_data_source.dart';
import 'package:aquabook/src/data/models/appointment_draft_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppointmentDraftRepository {
  AppointmentDraftRepository(this._auth, this._firestore);

  static const _collection = 'appointment_drafts';
  final AuthenticationDataSource _auth;
  final FirestoreDataSource _firestore;

  Future<void> saveDraft(AppointmentDraftModel draft) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;
    await _firestore.setDocument(
      collection: _collection,
      documentId: userId,
      data: {
        'customerId': userId,
        'businessId': draft.businessId,
        'businessName': draft.businessName,
        'businessImageUrl': draft.businessImageUrl,
        'selectedOfferingIds': draft.selectedOfferingIds,
        'selectedProviderId': draft.selectedProviderId,
        'selectedProviderName': draft.selectedProviderName,
        'date': draft.date,
        'startMinutes': draft.startMinutes,
        'selectedAddOnIds': draft.selectedAddOnIds,
        'updatedAt': _firestore.serverTimestamp,
      },
    );
  }

  Future<void> deleteDraft() async {
    final userId = _auth.currentUser?.uid;
    if (userId != null) {
      await _firestore.deleteDocument(
        collection: _collection,
        documentId: userId,
      );
    }
  }

  Future<AppointmentDraftModel?> getDraft() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return null;
    final data = await _firestore.getDocument(
      collection: _collection,
      documentId: userId,
    );
    if (data == null) return null;
    final value = data['date'];
    return AppointmentDraftModel(
      id: userId,
      businessId: data['businessId'] as String? ?? '',
      businessName: data['businessName'] as String? ?? '',
      businessImageUrl: data['businessImageUrl'] as String? ?? '',
      selectedOfferingIds: List<String>.from(
        data['selectedOfferingIds'] as List? ?? const [],
      ),
      selectedProviderId: data['selectedProviderId'] as String?,
      selectedProviderName: data['selectedProviderName'] as String?,
      date: value is Timestamp ? value.toDate() : DateTime.now(),
      startMinutes: (data['startMinutes'] as num?)?.toInt(),
      selectedAddOnIds: List<String>.from(
        data['selectedAddOnIds'] as List? ?? const [],
      ),
    );
  }
}
