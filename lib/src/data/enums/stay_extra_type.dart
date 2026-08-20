import 'package:dart_mappable/dart_mappable.dart';

part 'stay_extra_type.mapper.dart';

@MappableEnum()
enum StayExtraType {
  breakfast,
  parking,
  spaAccess,
  airportTransfer,
  lateCheckout,
  petStay,
  extraBed,
  laundryService,
}

extension StayExtraTypeLabel on StayExtraType {
  String get label => switch (this) {
    StayExtraType.breakfast => 'Breakfast',
    StayExtraType.parking => 'Parking',
    StayExtraType.spaAccess => 'Spa access',
    StayExtraType.airportTransfer => 'Airport transfer',
    StayExtraType.lateCheckout => 'Late checkout',
    StayExtraType.petStay => 'Pet stay',
    StayExtraType.extraBed => 'Extra bed',
    StayExtraType.laundryService => 'Laundry service',
  };

  String get description => switch (this) {
    StayExtraType.breakfast => 'Continental breakfast included',
    StayExtraType.parking => 'Secure parking service',
    StayExtraType.spaAccess => 'Full spa and wellness center',
    StayExtraType.airportTransfer => 'Private airport pickup or drop-off',
    StayExtraType.lateCheckout => 'Keep your room longer on departure day',
    StayExtraType.petStay => 'Bring your pet along for the stay',
    StayExtraType.extraBed => 'Additional bed prepared for your room',
    StayExtraType.laundryService => 'Laundry and garment care during your stay',
  };

  int get defaultPrice => switch (this) {
    StayExtraType.breakfast => 20,
    StayExtraType.parking => 15,
    StayExtraType.spaAccess => 40,
    StayExtraType.airportTransfer => 35,
    StayExtraType.lateCheckout => 25,
    StayExtraType.petStay => 15,
    StayExtraType.extraBed => 30,
    StayExtraType.laundryService => 18,
  };

  bool get isPerNight => switch (this) {
    StayExtraType.spaAccess ||
    StayExtraType.airportTransfer ||
    StayExtraType.lateCheckout => false,
    _ => true,
  };
}
