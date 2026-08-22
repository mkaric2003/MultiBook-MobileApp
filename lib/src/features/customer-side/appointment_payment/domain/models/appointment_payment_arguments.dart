import 'package:aquabook/src/features/customer-side/review_appointment/domain/models/review_appointment_arguments.dart';

class AppointmentPaymentArguments {
  const AppointmentPaymentArguments({required this.review});

  final ReviewAppointmentArguments review;

  int get serviceCost =>
      review.offerings.fold(0, (total, offering) => total + offering.price);

  double get serviceFee => serviceCost * 0.085;

  double get taxes => (serviceCost + serviceFee) * 0.1;

  double get total => serviceCost + serviceFee + taxes;
}
