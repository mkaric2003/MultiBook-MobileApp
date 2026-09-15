import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/business_review_model.dart';
import 'package:multibook/src/features/shared/rate_business/domain/models/rate_business_target.dart';

abstract class ReviewsRepository {
  Future<Result<void>> create({
    required RateBusinessTarget target,
    required int rating,
    String? comment,
  });

  Future<Result<bool>> hasReview(String businessId);

  Future<Result<List<BusinessReviewModel>>> getBusinessReviews(
    String businessId, {
    int? limit,
  });
}
