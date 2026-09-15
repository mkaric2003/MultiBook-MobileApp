import 'package:dart_mappable/dart_mappable.dart';

part 'booking_status.mapper.dart';

@MappableEnum()
enum BookingStatus { confirmed, declined, cancelled, completed, noShow }
