import 'package:multibook/src/core/errors/result.dart';

abstract class BusinessDeletionRepository {
  Future<Result<void>> deleteBusiness(String businessId);
}
