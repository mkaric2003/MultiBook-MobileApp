import 'package:dart_mappable/dart_mappable.dart';

part 'business_location_model.mapper.dart';

@MappableClass()
class BusinessLocationModel with BusinessLocationModelMappable {
  final String city;
  final String address;
  final double latitude;
  final double longitude;

  const BusinessLocationModel({
    this.city = '',
    required this.address,
    required this.latitude,
    required this.longitude,
  });
}
