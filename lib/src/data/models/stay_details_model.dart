import 'package:dart_mappable/dart_mappable.dart';

import '../enums/stay_amenity.dart';
import 'stay_extra_model.dart';
import 'stay_room_model.dart';

part 'stay_details_model.mapper.dart';

@MappableClass()
class StayDetailsModel with StayDetailsModelMappable {
  const StayDetailsModel({
    this.pricePerNight,
    this.amenities = const [],
    this.rooms = const [],
    this.extras = const [],
  });

  final int? pricePerNight;
  final List<StayAmenity> amenities;
  final List<StayRoomModel> rooms;
  final List<StayExtraModel> extras;
}
