import 'package:dart_mappable/dart_mappable.dart';

part 'stay_details_model.mapper.dart';

@MappableClass()
class StayDetailsModel with StayDetailsModelMappable {
  const StayDetailsModel({this.pricePerNight});

  final int? pricePerNight;
}
