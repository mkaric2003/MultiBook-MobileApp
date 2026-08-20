import 'package:aquabook/src/data/enums/stay_extra_type.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'stay_extra_model.mapper.dart';

@MappableClass()
class StayExtraModel with StayExtraModelMappable {
  const StayExtraModel({
    required this.type,
    required this.price,
    this.isPerNight = false,
    this.isPerHour = false,
  });

  final StayExtraType type;
  final int price;
  final bool isPerNight;
  final bool isPerHour;
}
