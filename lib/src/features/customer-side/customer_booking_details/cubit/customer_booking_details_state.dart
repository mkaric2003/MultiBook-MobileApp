import 'package:multibook/src/data/models/booking_model.dart';

class CustomerBookingDetailsState {
  const CustomerBookingDetailsState({
    required this.booking,
    this.isCancelling = false,
    this.hasSubmittedReview = false,
    this.errorMessage,
  });

  final BookingModel booking;
  final bool isCancelling;
  final bool hasSubmittedReview;
  final String? errorMessage;

  CustomerBookingDetailsState copyWith({
    BookingModel? booking,
    bool? isCancelling,
    bool? hasSubmittedReview,
    String? errorMessage,
  }) => CustomerBookingDetailsState(
    booking: booking ?? this.booking,
    isCancelling: isCancelling ?? this.isCancelling,
    hasSubmittedReview: hasSubmittedReview ?? this.hasSubmittedReview,
    errorMessage: errorMessage,
  );
}
