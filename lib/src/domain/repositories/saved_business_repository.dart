import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/business_model.dart';

abstract class SavedBusinessRepository {
  Future<Result<void>> save(String businessId);
  Future<Result<void>> remove(String businessId);
  Future<Result<bool>> isSaved(String businessId);
  Future<Result<List<BusinessModel>>> list();
}
