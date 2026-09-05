import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/domain/repositories/recently_viewed_repository.dart';

@injectable
class GetRecentlyViewedBusinessesUseCase {
  GetRecentlyViewedBusinessesUseCase(this._repository);
  final RecentlyViewedRepository _repository;
  Future<Result<List<BusinessModel>>> execute(BusinessType type) =>
      _repository.list(type);
}
