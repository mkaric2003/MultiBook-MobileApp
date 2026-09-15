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
