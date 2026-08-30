import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/data/models/business_model.dart';

abstract class CustomerDiscoveryRepository {
  Future<Result<List<BusinessModel>>> recommendedStays();
  Future<Result<List<BusinessModel>>> popularNearCity({
    required BusinessType type,
    required String city,
    required int offset,
    int limit = 10,
  });
}
