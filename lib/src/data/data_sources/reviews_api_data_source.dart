import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/networking/api_client.dart';
import 'package:multibook/src/data/data_sources/firebase_storage_data_source.dart';
import 'package:multibook/src/data/models/business_review_model.dart';
import 'package:multibook/src/data/models/review_list_response.dart';
import 'package:multibook/src/features/shared/rate_business/domain/models/rate_business_target.dart';

@lazySingleton
class ReviewsApiDataSource {
  ReviewsApiDataSource(this._client, this._storage);

  final ApiClient _client;
  final FirebaseStorageDataSource _storage;

  Future<void> create({
    required RateBusinessTarget target,
    required int rating,
    String? comment,
  }) => _client.post(
    '/v1/businesses/${target.businessId}/reviews',
    data: {
      'sourceId': target.sourceId,
      'type': target.type.name,
      'rating': rating,
      'comment': comment,
    },
  );

  Future<bool> hasReview(String businessId) async {
    final response = await _client.get(
      '/v1/businesses/$businessId/review-status',
    );
    return response.data!['hasReview'] as bool? ?? false;
  }

  Future<ReviewListResponse> getBusinessReviewsPage(
    String businessId, {
    required int limit,
    required int offset,
  }) async {
    final response = await _client.get(
      '/v1/businesses/$businessId/reviews',
      queryParameters: {'limit': limit, 'offset': offset},
    );
    final page = ReviewListResponseMapper.fromMap(response.data!);
    return ReviewListResponse(
      items: await Future.wait(page.items.map(_resolveAvatar)),
      nextOffset: page.nextOffset,
    );
  }

  Future<BusinessReviewModel> _resolveAvatar(BusinessReviewModel review) async {
    final path = review.customerAvatarUrl;
    if (path == null || path.isEmpty) return review;
    return review.copyWith(
      customerAvatarUrl: await _storage.getDownloadUrl(storagePath: path),
    );
  }
}
