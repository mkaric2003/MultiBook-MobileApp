import 'package:aquabook/src/data/repositories/appointment_repository.dart';
import 'package:aquabook/src/features/customer-side/create_appointment/cubit/appointment_availability_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppointmentAvailabilityCubit extends Cubit<AppointmentAvailabilityState> {
  AppointmentAvailabilityCubit(this._repository)
    : super(const AppointmentAvailabilityState());

  final AppointmentRepository _repository;
  var _requestId = 0;

  Future<void> load({
    required String businessId,
    required String providerId,
    required DateTime date,
  }) async {
    final requestId = ++_requestId;
    emit(const AppointmentAvailabilityState(isLoading: true));
    try {
      final bookedStartMinutes = await _repository.getBookedSlotStarts(
        businessId: businessId,
        providerId: providerId,
        date: date,
      );
      if (isClosed || requestId != _requestId) return;
      emit(
        AppointmentAvailabilityState(bookedStartMinutes: bookedStartMinutes),
      );
    } on AppointmentException catch (error) {
      if (isClosed || requestId != _requestId) return;
      emit(AppointmentAvailabilityState(errorMessage: error.message));
    }
  }

  void reset() {
    _requestId++;
    emit(const AppointmentAvailabilityState());
  }
}
