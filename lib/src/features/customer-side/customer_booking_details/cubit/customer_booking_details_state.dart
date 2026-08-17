import 'package:aquabook/src/data/models/booking_model.dart';

class CustomerBookingDetailsState {
  const CustomerBookingDetailsState({
    required this.booking,
    this.isCancelling = false,
    this.errorMessage,
  });

  final BookingModel booking;
  final bool isCancelling;
  final String? errorMessage;

  CustomerBookingDetailsState copyWith({
    BookingModel? booking,
    bool? isCancelling,
    String? errorMessage,
  }) => CustomerBookingDetailsState(
    booking: booking ?? this.booking,
    isCancelling: isCancelling ?? this.isCancelling,
    errorMessage: errorMessage,
  );
}
