import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/repositories/reviews_repository.dart';

@injectable
class HasBusinessReviewUseCase {
  HasBusinessReviewUseCase(this._repository);
  final ReviewsRepository _repository;
  Future<Result<bool>> execute(String businessId) =>
      _repository.hasReview(businessId);
}
