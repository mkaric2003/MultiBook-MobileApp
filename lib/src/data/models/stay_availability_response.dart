import 'package:dart_mappable/dart_mappable.dart';
import 'package:multibook/src/data/models/stay_unavailable_range.dart';

part 'stay_availability_response.mapper.dart';

@MappableClass()
class StayAvailabilityResponse with StayAvailabilityResponseMappable {
  const StayAvailabilityResponse({required this.unavailableRanges});

  final List<StayUnavailableRange> unavailableRanges;
}
