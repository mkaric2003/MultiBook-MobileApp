import 'dart:async';
import 'dart:developer';

import 'package:multibook/src/data/data_sources/authentication_data_source.dart';
import 'package:multibook/src/data/data_sources/firestore_data_source.dart';
import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RecentlyViewedRepository {
  RecentlyViewedRepository(this._auth, this._firestore);

  static const _maximumItems = 30;

  final AuthenticationDataSource _auth;
  final FirestoreDataSource _firestore;
  final StreamController<void> _changes = StreamController<void>.broadcast();

  String? get _userId => _auth.currentUser?.uid;

  Stream<void> get changes => _changes.stream;

  String _collectionFor(String userId) => 'users/$userId/recently_viewed';

  Future<void> recordBusinessView(BusinessModel business) async {
    final userId = _userId;
    if (userId == null) return;

    final collection = _collectionFor(userId);
    try {
      await _firestore.setDocument(
        collection: collection,
        documentId: business.id,
        data: {
          'businessId': business.id,
          'type': business.type.name,
          'name': business.name,
          'location': business.location.city,
          'imageUrl': business.coverPhotoUrl ?? business.logoUrl ?? '',
          'pricePerNight': business.stayDetails?.pricePerNight,
          'servicePrice': business.serviceDetails?.offerings.firstOrNull?.price,
          'serviceDurationMinutes':
              business.serviceDetails?.offerings.firstOrNull?.durationMinutes,
          'rating': business.averageRating,
          'reviewCount': business.reviewCount,
          'viewedAt': _firestore.serverTimestamp,
          'viewedAtMillis': DateTime.now().millisecondsSinceEpoch,
        },
        merge: true,
      );
      await _trimToMaximum(collection);
      _changes.add(null);
    } catch (error, stackTrace) {
      log(
        'Could not record recently viewed business.',
        name: 'RecentlyViewedRepository',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<List<StayListing>> getRecentStays({int limit = 10}) async {
    final userId = _userId;
    if (userId == null) return const [];

    try {
      final documents = await _firestore.getDocumentsOrdered(
        collection: _collectionFor(userId),
        orderBy: 'viewedAtMillis',
        descending: true,
      );
      return documents
          .where((item) => item['type'] == BusinessType.stays.name)
          .take(limit)
          .map(
            (item) => StayListing(
              id: item['businessId'] as String? ?? '',
              name: item['name'] as String? ?? '',
              location: item['location'] as String? ?? '',
              pricePerNight: (item['pricePerNight'] as num?)?.toInt(),
              rating: (item['rating'] as num?)?.toDouble() ?? 0,
              reviewCount: (item['reviewCount'] as num?)?.toInt() ?? 0,
              imageUrl: item['imageUrl'] as String? ?? '',
            ),
          )
          .where((stay) => stay.id.isNotEmpty)
          .toList();
    } catch (error, stackTrace) {
      log(
        'Could not load recently viewed stays.',
        name: 'RecentlyViewedRepository',
        error: error,
        stackTrace: stackTrace,
      );
      return const [];
    }
  }

  Future<List<ServiceListing>> getRecentServices({int limit = 10}) async {
    final userId = _userId;
    if (userId == null) return const [];

    try {
      final documents = await _firestore.getDocumentsOrdered(
        collection: _collectionFor(userId),
        orderBy: 'viewedAtMillis',
        descending: true,
      );
      return documents
          .where((item) => item['type'] == BusinessType.services.name)
          .take(limit)
          .map(
            (item) => ServiceListing(
              id: item['businessId'] as String? ?? '',
              name: item['name'] as String? ?? '',
              location: item['location'] as String? ?? '',
              price: (item['servicePrice'] as num?)?.toInt(),
              durationMinutes: (item['serviceDurationMinutes'] as num?)
                  ?.toInt(),
              rating: (item['rating'] as num?)?.toDouble() ?? 0,
              reviewCount: (item['reviewCount'] as num?)?.toInt() ?? 0,
              imageUrl: item['imageUrl'] as String? ?? '',
            ),
          )
          .where((service) => service.id.isNotEmpty)
          .toList();
    } catch (error, stackTrace) {
      log(
        'Could not load recently viewed services.',
        name: 'RecentlyViewedRepository',
        error: error,
        stackTrace: stackTrace,
      );
      return const [];
    }
  }

  Future<void> _trimToMaximum(String collection) async {
    final documents = await _firestore.getDocumentsOrdered(
      collection: collection,
      orderBy: 'viewedAtMillis',
      descending: true,
    );
    for (final document in documents.skip(_maximumItems)) {
      final businessId = document['businessId'] as String?;
      if (businessId == null || businessId.isEmpty) continue;
      await _firestore.deleteDocument(
        collection: collection,
        documentId: businessId,
      );
    }
  }
}
