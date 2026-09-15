import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/data/models/business_model.dart';

abstract class RecentlyViewedRepository {
  Future<Result<void>> record(String businessId);
  Future<Result<List<BusinessModel>>> list(BusinessType type, {int limit = 10});
}
