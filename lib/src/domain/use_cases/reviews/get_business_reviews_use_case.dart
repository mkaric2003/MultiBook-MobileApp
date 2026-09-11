import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/business_review_model.dart';
import 'package:multibook/src/domain/repositories/reviews_repository.dart';

@injectable
class GetBusinessReviewsUseCase {
  GetBusinessReviewsUseCase(this._repository);

  final ReviewsRepository _repository;

  Future<Result<List<BusinessReviewModel>>> execute(
    String businessId, {
    int? limit,
  }) => _repository.getBusinessReviews(businessId, limit: limit);
}
