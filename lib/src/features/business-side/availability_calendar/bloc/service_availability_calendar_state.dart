import 'package:aquabook/src/data/models/appointment_model.dart';
import 'package:aquabook/src/data/models/service_availability_block_model.dart';

class ServiceAvailabilityCalendarState {
  const ServiceAvailabilityCalendarState({
    this.isLoading = true,
    this.appointments = const [],
    this.blocks = const [],
    this.errorMessage,
  });

  final bool isLoading;
  final List<AppointmentModel> appointments;
  final List<ServiceAvailabilityBlockModel> blocks;
  final String? errorMessage;

  ServiceAvailabilityCalendarState copyWith({
    bool? isLoading,
    List<AppointmentModel>? appointments,
    List<ServiceAvailabilityBlockModel>? blocks,
    String? errorMessage,
  }) => ServiceAvailabilityCalendarState(
    isLoading: isLoading ?? this.isLoading,
    appointments: appointments ?? this.appointments,
    blocks: blocks ?? this.blocks,
    errorMessage: errorMessage,
  );
}
