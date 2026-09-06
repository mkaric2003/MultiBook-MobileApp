import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/repositories/reviews_repository.dart';
import 'package:multibook/src/features/shared/rate_business/domain/models/rate_business_target.dart';

@injectable
class CreateReviewUseCase {
  CreateReviewUseCase(this._repository);
  final ReviewsRepository _repository;

  Future<Result<void>> execute({
    required RateBusinessTarget target,
    required int rating,
    String? comment,
  }) => _repository.create(target: target, rating: rating, comment: comment);
}
