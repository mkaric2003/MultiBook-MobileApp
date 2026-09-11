import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/available_appointment_slots_model.dart';
import 'package:multibook/src/domain/use_cases/appointments/get_available_appointment_slots_use_case.dart';
import 'package:multibook/src/features/customer-side/create_appointment/cubit/appointment_availability_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppointmentAvailabilityCubit extends Cubit<AppointmentAvailabilityState> {
  AppointmentAvailabilityCubit(this._getAvailableSlotsUseCase)
    : super(const AppointmentAvailabilityState());

  final GetAvailableAppointmentSlotsUseCase _getAvailableSlotsUseCase;
  var _requestId = 0;

  Future<void> load({
    required String businessId,
    required String providerId,
    required DateTime date,
    required List<String> offeringIds,
    String? excludeAppointmentId,
  }) async {
    final requestId = ++_requestId;
    emit(const AppointmentAvailabilityState(isLoading: true));
    final result = await _getAvailableSlotsUseCase.execute(
      businessId: businessId,
      staffId: providerId,
      appointmentDate: date,
      offeringIds: offeringIds,
      excludeAppointmentId: excludeAppointmentId,
    );
    if (isClosed || requestId != _requestId) return;
    if (result case Success<AvailableAppointmentSlotsModel>(:final value)) {
      emit(
        AppointmentAvailabilityState(
          availableStartMinutes: value.startMinutes.toSet(),
        ),
      );
    } else {
      if (isClosed || requestId != _requestId) return;
      emit(
        const AppointmentAvailabilityState(
          errorMessage: 'We could not load availability. Please try again.',
        ),
      );
    }
  }

  void reset() {
    _requestId++;
    emit(const AppointmentAvailabilityState());
  }
}
