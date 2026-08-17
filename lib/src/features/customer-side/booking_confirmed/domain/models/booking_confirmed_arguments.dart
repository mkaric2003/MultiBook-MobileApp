import 'package:aquabook/src/features/customer-side/payment/domain/models/payment_arguments.dart';

class BookingConfirmedArguments {
  const BookingConfirmedArguments({required this.payment});
  final PaymentArguments payment;
}
