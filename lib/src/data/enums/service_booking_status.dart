import 'package:dart_mappable/dart_mappable.dart';

part 'service_booking_status.mapper.dart';

@MappableEnum()
enum ServiceBookingStatus { pending, confirmed, cancelled, completed, noShow }
