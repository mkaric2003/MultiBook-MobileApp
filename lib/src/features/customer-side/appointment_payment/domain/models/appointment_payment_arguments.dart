import 'package:aquabook/src/features/customer-side/review_appointment/domain/models/appointment_add_on.dart';
import 'package:aquabook/src/features/customer-side/review_appointment/domain/models/review_appointment_arguments.dart';

class AppointmentPaymentArguments {
  const AppointmentPaymentArguments({
    required this.review,
    required this.selectedAddOns,
  });

  final ReviewAppointmentArguments review;
  final List<AppointmentAddOn> selectedAddOns;

  int get serviceCost =>
      review.offerings.fold(0, (total, offering) => total + offering.price);

  int get addOnsCost =>
      selectedAddOns.fold(0, (total, addOn) => total + addOn.price);

  double get serviceFee => (serviceCost + addOnsCost) * 0.085;

  double get taxes => (serviceCost + addOnsCost + serviceFee) * 0.1;

  double get total => serviceCost + addOnsCost + serviceFee + taxes;
}
