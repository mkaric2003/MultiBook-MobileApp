import 'package:multibook/src/data/models/booking_model.dart';

class PaymentState {
  const PaymentState({
    this.isProcessing = false,
    this.booking,
    this.errorMessage,
  });
  final bool isProcessing;
  final BookingModel? booking;
  final String? errorMessage;
}
