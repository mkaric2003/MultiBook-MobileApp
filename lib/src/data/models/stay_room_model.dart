import 'package:dart_mappable/dart_mappable.dart';

part 'stay_room_model.mapper.dart';

@MappableClass()
class StayRoomModel with StayRoomModelMappable {
  const StayRoomModel({
    required this.name,
    required this.maxGuests,
    required this.sizeSquareMeters,
    required this.pricePerNight,
  });

  final String name;
  final int maxGuests;
  final int sizeSquareMeters;
  final int pricePerNight;
}
