import 'package:aquabook/src/data/enums/booking_status.dart';

class AvailabilityDaySummary {
  const AvailabilityDaySummary({
    required this.statuses,
    required this.bookedRooms,
    required this.totalRooms,
  });

  final List<BookingStatus> statuses;
  final int bookedRooms;
  final int totalRooms;

  AvailabilityDaySummary copyWith({
    List<BookingStatus>? statuses,
    int? bookedRooms,
  }) => AvailabilityDaySummary(
    statuses: statuses ?? this.statuses,
    bookedRooms: bookedRooms ?? this.bookedRooms,
    totalRooms: totalRooms,
  );
}
