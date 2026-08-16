import 'package:dart_mappable/dart_mappable.dart';

part 'stay_booking_status.mapper.dart';

@MappableEnum()
enum StayBookingStatus { pending, confirmed, cancelled, completed }
