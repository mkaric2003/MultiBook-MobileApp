import 'package:dart_mappable/dart_mappable.dart';

part 'stay_unavailable_range.mapper.dart';

@MappableClass()
class StayUnavailableRange with StayUnavailableRangeMappable {
  const StayUnavailableRange({required this.checkIn, required this.checkOut});

  final DateTime checkIn;
  final DateTime checkOut;
}
