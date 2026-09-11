import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/reschedule_appointment_request.dart';
import 'package:multibook/src/domain/use_cases/appointments/reschedule_customer_appointment_use_case.dart';
import 'package:multibook/src/features/customer-side/reschedule_appointment/cubit/reschedule_appointment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RescheduleAppointmentCubit extends Cubit<RescheduleAppointmentState> {
  RescheduleAppointmentCubit(this._rescheduleCustomerAppointmentUseCase)
    : super(const RescheduleAppointmentState());

  final RescheduleCustomerAppointmentUseCase
  _rescheduleCustomerAppointmentUseCase;

  Future<void> submit({
    required AppointmentModel appointment,
    required DateTime date,
    required int startMinutes,
  }) async {
    if (state.isSubmitting) return;
    emit(const RescheduleAppointmentState(isSubmitting: true));
    final result = await _rescheduleCustomerAppointmentUseCase.execute(
      appointmentId: appointment.id,
      request: RescheduleAppointmentRequest(
        appointmentDate: _date(date),
        startMinutes: startMinutes,
      ),
    );
    if (result is Success<AppointmentModel>) {
      emit(RescheduleAppointmentState(appointment: result.value));
      return;
    }
    emit(
      const RescheduleAppointmentState(
        errorMessage:
            'We could not reschedule your appointment. Please try again.',
      ),
    );
  }

  String _date(DateTime value) =>
      '${value.year.toString().padLeft(4, '0')}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';
}
