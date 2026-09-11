import 'package:multibook/src/data/models/business_location_model.dart';

abstract class BusinessLocationRepository {
  Future<BusinessLocationModel?> resolve({
    required double latitude,
    required double longitude,
  });
}
