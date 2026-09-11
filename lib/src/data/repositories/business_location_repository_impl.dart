import 'package:injectable/injectable.dart';
import 'package:multibook/src/data/data_sources/nominatim_data_source.dart';
import 'package:multibook/src/data/models/business_location_model.dart';
import 'package:multibook/src/domain/repositories/business_location_repository.dart';

@LazySingleton(as: BusinessLocationRepository)
class BusinessLocationRepositoryImpl implements BusinessLocationRepository {
  BusinessLocationRepositoryImpl(this._source);

  final NominatimDataSource _source;

  @override
  Future<BusinessLocationModel?> resolve({
    required double latitude,
    required double longitude,
  }) => _source.reverseGeocode(latitude: latitude, longitude: longitude);
}
