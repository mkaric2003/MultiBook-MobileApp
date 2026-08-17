import 'package:aquabook/src/data/data_sources/authentication_data_source.dart';
import 'package:aquabook/src/data/data_sources/firestore_data_source.dart';
import 'package:aquabook/src/data/models/booking_draft_model.dart';
import 'package:aquabook/src/data/models/stay_extra_model.dart';
import 'package:aquabook/src/data/enums/stay_extra_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class BookingDraftRepository {
  BookingDraftRepository(this._auth, this._firestore);
  final AuthenticationDataSource _auth;
  final FirestoreDataSource _firestore;
  static const _collection = 'booking_drafts';

  Future<BookingDraftModel?> getDraft() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return null;
    final data = await _firestore.getDocument(
      collection: _collection,
      documentId: userId,
    );
    if (data == null) return null;
    return BookingDraftModel(
      id: userId,
      businessId: data['businessId'] as String? ?? '',
      businessName: data['businessName'] as String? ?? '',
      businessLocation: data['businessLocation'] as String? ?? '',
      businessImageUrl: data['businessImageUrl'] as String? ?? '',
      pricePerNight: (data['pricePerNight'] as num?)?.toInt() ?? 0,
      checkIn: _date(data['checkIn']),
      checkOut: _date(data['checkOut']),
      adults: (data['adults'] as num?)?.toInt() ?? 1,
      children: (data['children'] as num?)?.toInt() ?? 0,
      infants: (data['infants'] as num?)?.toInt() ?? 0,
      roomTypeId: data['roomTypeId'] as String?,
      selectedExtras: (data['selectedExtras'] as List? ?? const [])
          .whereType<Map>()
          .map(
            (extra) => StayExtraModel(
              type: StayExtraType.values.byName(extra['type'] as String),
              price: (extra['price'] as num?)?.toInt() ?? 0,
              isPerNight: extra['isPerNight'] as bool? ?? false,
            ),
          )
          .toList(),
    );
  }

  Future<void> saveDraft(BookingDraftModel draft) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;
    await _firestore.setDocument(
      collection: _collection,
      documentId: userId,
      data: {
        'customerId': userId,
        'businessId': draft.businessId,
        'businessName': draft.businessName,
        'businessLocation': draft.businessLocation,
        'businessImageUrl': draft.businessImageUrl,
        'pricePerNight': draft.pricePerNight,
        'checkIn': draft.checkIn,
        'checkOut': draft.checkOut,
        'adults': draft.adults,
        'children': draft.children,
        'infants': draft.infants,
        'roomTypeId': draft.roomTypeId,
        'selectedExtras': draft.selectedExtras
            .map(
              (extra) => {
                'type': extra.type.name,
                'price': extra.price,
                'isPerNight': extra.isPerNight,
              },
            )
            .toList(),
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

  DateTime _date(Object? value) =>
      value is Timestamp ? value.toDate() : DateTime.now();
}
