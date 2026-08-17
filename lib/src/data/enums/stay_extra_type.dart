import 'package:dart_mappable/dart_mappable.dart';

part 'stay_extra_type.mapper.dart';

@MappableEnum()
enum StayExtraType { breakfast, parking, spaAccess }

extension StayExtraTypeLabel on StayExtraType {
  String get label => switch (this) {
    StayExtraType.breakfast => 'Breakfast',
    StayExtraType.parking => 'Parking',
    StayExtraType.spaAccess => 'Spa access',
  };

  String get description => switch (this) {
    StayExtraType.breakfast => 'Continental breakfast included',
    StayExtraType.parking => 'Secure parking service',
    StayExtraType.spaAccess => 'Full spa and wellness center',
  };
}
