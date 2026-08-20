import 'package:dart_mappable/dart_mappable.dart';

part 'stay_amenity.mapper.dart';

@MappableEnum()
enum StayAmenity {
  wifi,
  parking,
  pool,
  spa,
  petFriendly,
  gym,
  airConditioning,
  heating,
  kitchen,
  washer,
  balcony,
  seaView,
  mountainView,
  workspace,
  elevator,
  skiInSkiOut,
  skiStorage,
  skiRental,
  skiShuttle,
}

extension StayAmenityLabel on StayAmenity {
  String get label => switch (this) {
    StayAmenity.wifi => 'Wi-Fi',
    StayAmenity.parking => 'Parking',
    StayAmenity.pool => 'Pool',
    StayAmenity.spa => 'Spa',
    StayAmenity.petFriendly => 'Pet-friendly',
    StayAmenity.gym => 'Gym',
    StayAmenity.airConditioning => 'Air conditioning',
    StayAmenity.heating => 'Heating',
    StayAmenity.kitchen => 'Kitchen',
    StayAmenity.washer => 'Washer',
    StayAmenity.balcony => 'Balcony',
    StayAmenity.seaView => 'Sea view',
    StayAmenity.mountainView => 'Mountain view',
    StayAmenity.workspace => 'Workspace',
    StayAmenity.elevator => 'Elevator',
    StayAmenity.skiInSkiOut => 'Ski-in / ski-out',
    StayAmenity.skiStorage => 'Ski storage',
    StayAmenity.skiRental => 'Ski rental',
    StayAmenity.skiShuttle => 'Ski shuttle',
  };
}
