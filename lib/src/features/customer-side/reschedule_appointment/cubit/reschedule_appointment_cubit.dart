import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/data/repositories/appointment_repository.dart';
import 'package:multibook/src/features/customer-side/reschedule_appointment/cubit/reschedule_appointment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RescheduleAppointmentCubit extends Cubit<RescheduleAppointmentState> {
  RescheduleAppointmentCubit(this._repository)
    : super(const RescheduleAppointmentState());

  final AppointmentRepository _repository;

  Future<void> submit({
    required AppointmentModel appointment,
    required DateTime date,
    required int startMinutes,
  }) async {
    if (state.isSubmitting) return;
    emit(const RescheduleAppointmentState(isSubmitting: true));
    try {
      final updated = await _repository.rescheduleAppointment(
        appointment: appointment,
        date: date,
        startMinutes: startMinutes,
      );
      emit(RescheduleAppointmentState(appointment: updated));
    } on AppointmentException catch (error) {
      emit(RescheduleAppointmentState(errorMessage: error.message));
    }
  }
}
