import 'package:dart_mappable/dart_mappable.dart';

part 'booking_extra_request.mapper.dart';

@MappableClass()
class BookingExtraRequest with BookingExtraRequestMappable {
  const BookingExtraRequest({required this.type});

  final String type;
}
