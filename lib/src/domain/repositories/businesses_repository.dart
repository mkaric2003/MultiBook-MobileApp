import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/business_model.dart';

abstract class BusinessesRepository {
  Future<Result<BusinessModel>> createBusiness(BusinessModel business);

  Future<Result<List<BusinessModel>>> getOwnedBusinesses();

  Future<Result<BusinessModel>> getOwnedBusiness(String businessId);

  Future<Result<BusinessModel>> updateBusiness(BusinessModel business);
}
