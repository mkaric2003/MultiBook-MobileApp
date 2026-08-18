import 'package:aquabook/src/data/data_sources/authentication_data_source.dart';
import 'package:aquabook/src/data/data_sources/firestore_data_source.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SavedBusinessRepository {
  SavedBusinessRepository(this._auth, this._firestore);
  final AuthenticationDataSource _auth;
  final FirestoreDataSource _firestore;
  String? get _userId => _auth.currentUser?.uid;
  String _collectionFor(String userId) => 'saved_businesses/$userId/items';

  Future<bool> isSaved(String businessId) async {
    final userId = _userId;
    if (userId == null) return false;
    return await _firestore.getDocument(
          collection: _collectionFor(userId),
          documentId: businessId,
        ) !=
        null;
  }

  Future<void> toggle(StayListing stay, bool saved) async {
    final userId = _userId;
    if (userId == null) return;
    final collection = _collectionFor(userId);
    if (saved) {
      await _firestore.deleteDocument(collection: collection, documentId: stay.id);
      return;
    }
    await _firestore.setDocument(
      collection: collection,
      documentId: stay.id,
      data: {
        'businessId': stay.id,
        'name': stay.name,
        'location': stay.location,
        'pricePerNight': stay.pricePerNight,
        'rating': stay.rating,
        'reviewCount': stay.reviewCount,
        'imageUrl': stay.imageUrl,
        'createdAt': _firestore.serverTimestamp,
      },
    );
  }

  Future<List<StayListing>> getSaved() async {
    final userId = _userId;
    if (userId == null) return const [];
    final data = await _firestore.getDocuments(
      collection: _collectionFor(userId),
    );
    return data
        .map(
          (item) => StayListing(
            id: item['businessId'] as String,
            name: item['name'] as String,
            location: item['location'] as String? ?? '',
            pricePerNight: (item['pricePerNight'] as num?)?.toInt(),
            rating: (item['rating'] as num?)?.toDouble() ?? 0,
            reviewCount: (item['reviewCount'] as num?)?.toInt() ?? 0,
            imageUrl: item['imageUrl'] as String? ?? '',
          ),
        )
        .toList();
  }
}
