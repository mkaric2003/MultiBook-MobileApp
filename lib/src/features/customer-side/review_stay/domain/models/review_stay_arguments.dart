import 'package:multibook/src/features/customer-side/booking_details/bloc/booking_details_state.dart';
import 'package:multibook/src/features/customer-side/booking_details/domain/models/booking_details_arguments.dart';

class ReviewStayArguments {
  const ReviewStayArguments({
    required this.booking,
    required this.bookingState,
  });

  final BookingDetailsArguments booking;
  final BookingDetailsState bookingState;
}
