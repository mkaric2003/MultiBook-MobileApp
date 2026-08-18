import 'package:aquabook/src/data/models/booking_model.dart';
import 'package:aquabook/src/data/models/business_model.dart';

class AvailabilityCalendarState {
  const AvailabilityCalendarState({
    this.isLoading = true,
    this.business,
    this.bookings = const [],
    this.errorMessage,
  });

  final bool isLoading;
  final BusinessModel? business;
  final List<BookingModel> bookings;
  final String? errorMessage;
}
