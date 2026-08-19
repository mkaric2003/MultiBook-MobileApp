import 'package:aquabook/src/data/models/business_model.dart';
import 'package:aquabook/src/data/models/appointment_model.dart';

class AppointmentDetailsState {
  const AppointmentDetailsState({
    this.isLoading = true,
    this.business,
    this.appointment,
    this.isCancelling = false,
    this.errorMessage,
  });

  final bool isLoading;
  final BusinessModel? business;
  final AppointmentModel? appointment;
  final bool isCancelling;
  final String? errorMessage;
}
