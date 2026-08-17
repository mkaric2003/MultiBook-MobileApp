import 'package:dart_mappable/dart_mappable.dart';

part 'stay_room_model.mapper.dart';

@MappableClass()
class StayRoomModel with StayRoomModelMappable {
  const StayRoomModel({
    required this.id,
    required this.name,
    required this.maxGuests,
    required this.sizeSquareMeters,
    required this.pricePerNight,
    this.quantity = 1,
  });

  final String id;
  final String name;
  final int maxGuests;
  final int sizeSquareMeters;
  final int pricePerNight;
  final int quantity;
}
