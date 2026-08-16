import 'package:dart_mappable/dart_mappable.dart';

part 'stay_amenity.mapper.dart';

@MappableEnum()
enum StayAmenity { wifi, parking, pool, spa, petFriendly, gym }

extension StayAmenityLabel on StayAmenity {
  String get label => switch (this) {
    StayAmenity.wifi => 'Wi-Fi',
    StayAmenity.parking => 'Parking',
    StayAmenity.pool => 'Pool',
    StayAmenity.spa => 'Spa',
    StayAmenity.petFriendly => 'Pet-friendly',
    StayAmenity.gym => 'Gym',
  };
}
