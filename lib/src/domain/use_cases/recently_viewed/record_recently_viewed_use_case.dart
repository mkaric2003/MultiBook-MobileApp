import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/repositories/recently_viewed_repository.dart';

@injectable
class RecordRecentlyViewedUseCase {
  RecordRecentlyViewedUseCase(this._repository);
  final RecentlyViewedRepository _repository;
  Future<Result<void>> execute(String businessId) =>
      _repository.record(businessId);
}
