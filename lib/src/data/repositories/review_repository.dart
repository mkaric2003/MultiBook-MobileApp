import 'dart:developer';

import 'package:aquabook/src/data/data_cursor.dart';
import 'package:aquabook/src/data/data_sources/firestore_data_source.dart';
import 'package:aquabook/src/data/data_sources/review_data_source.dart';
import 'package:aquabook/src/data/data_sources/authentication_data_source.dart';
import 'package:aquabook/src/data/models/business_review_model.dart';
import 'package:aquabook/src/features/shared/rate_business/domain/models/rate_business_target.dart';
import 'package:injectable/injectable.dart';

class ReviewException implements Exception {
  const ReviewException(this.message);

  final String message;
}

@lazySingleton
class ReviewRepository {
  ReviewRepository(this._dataSource, this._firestore, this._auth);

  static const _collection = 'reviews';

  final ReviewDataSource _dataSource;
  final FirestoreDataSource _firestore;
  final AuthenticationDataSource _auth;

  Future<bool> hasReview(RateBusinessTarget target) async {
    final customerId = _auth.currentUser?.uid;
    if (customerId == null) return false;
    final review = await _firestore.getDocument(
      collection: _collection,
      documentId: _reviewId(target.businessId, customerId),
    );
    return review != null;
  }

  Future<List<BusinessReviewModel>> getPreviewReviews(String businessId) {
    final cursor = _reviewsCursor(businessId, pageSize: 4);
    return cursor.fetchNextPage();
  }

  Future<List<BusinessReviewModel>> getAllReviews(String businessId) async {
    final cursor = _reviewsCursor(businessId, pageSize: 20);
    final reviews = <BusinessReviewModel>[];
    while (!cursor.isEverythingLoaded) {
      reviews.addAll(await cursor.fetchNextPage());
    }
    return reviews;
  }

  DataCursor<BusinessReviewModel> _reviewsCursor(
    String businessId, {
    required int pageSize,
  }) => _firestore.createCursorWhere<BusinessReviewModel>(
    collection: _collection,
    field: 'businessId',
    value: businessId,
    orderBy: 'createdAt',
    descending: true,
    pageSize: pageSize,
    listSerializer: (documents) =>
        documents.map(BusinessReviewModel.fromJson).toList(),
  );

  Future<void> createReview({
    required RateBusinessTarget target,
    required int rating,
    String? comment,
  }) async {
    try {
      await _dataSource.createReview(
        businessId: target.businessId,
        sourceId: target.sourceId,
        type: target.type.name,
        rating: rating,
        comment: comment?.trim().isEmpty ?? true ? null : comment!.trim(),
      );
    } catch (error, stackTrace) {
      log(
        'Could not create review for ${target.sourceId}.',
        name: 'ReviewRepository',
        error: error,
        stackTrace: stackTrace,
      );
      throw const ReviewException('Unable to submit review.');
    }
  }

  String _reviewId(String businessId, String customerId) =>
      '${businessId}_$customerId';
}
