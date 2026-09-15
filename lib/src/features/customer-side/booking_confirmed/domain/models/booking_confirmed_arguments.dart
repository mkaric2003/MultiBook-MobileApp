import 'package:multibook/src/features/customer-side/payment/domain/models/payment_arguments.dart';
import 'package:multibook/src/data/models/booking_model.dart';

class BookingConfirmedArguments {
  const BookingConfirmedArguments({
    required this.payment,
    required this.booking,
  });
  final PaymentArguments payment;
  final BookingModel booking;
}
