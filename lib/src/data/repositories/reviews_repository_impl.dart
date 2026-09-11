import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/rest_repository_executor.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/data_sources/reviews_api_data_source.dart';
import 'package:multibook/src/data/models/business_review_model.dart';
import 'package:multibook/src/domain/repositories/reviews_repository.dart';
import 'package:multibook/src/features/shared/rate_business/domain/models/rate_business_target.dart';

@LazySingleton(as: ReviewsRepository)
class ReviewsRepositoryImpl implements ReviewsRepository {
  ReviewsRepositoryImpl(this._source, this._executor);

  final ReviewsApiDataSource _source;
  final RestRepositoryExecutor _executor;

  @override
  Future<Result<void>> create({
    required RateBusinessTarget target,
    required int rating,
    String? comment,
  }) => _executor.execute(
    () => _source.create(
      target: target,
      rating: rating,
      comment: _normalizedComment(comment),
    ),
  );

  @override
  Future<Result<bool>> hasReview(String businessId) =>
      _executor.execute(() => _source.hasReview(businessId));

  @override
  Future<Result<List<BusinessReviewModel>>> getBusinessReviews(
    String businessId, {
    int? limit,
  }) => _executor.execute(() async {
    final reviews = <BusinessReviewModel>[];
    int? offset = 0;
    while (offset != null) {
      final remaining = limit == null ? 20 : limit - reviews.length;
      if (remaining <= 0) break;
      final page = await _source.getBusinessReviewsPage(
        businessId,
        limit: remaining < 20 ? remaining : 20,
        offset: offset,
      );
      reviews.addAll(page.items);
      offset = page.nextOffset;
    }
    return reviews;
  });

  String? _normalizedComment(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
