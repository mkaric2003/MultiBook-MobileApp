import 'package:multibook/src/data/repositories/appointment_draft_repository.dart';
import 'package:multibook/src/data/repositories/appointment_repository.dart';
import 'package:multibook/src/features/customer-side/appointment_payment/cubit/appointment_payment_state.dart';
import 'package:multibook/src/features/customer-side/appointment_payment/domain/models/appointment_payment_arguments.dart';
import 'package:multibook/src/features/customer-side/appointment_payment/domain/models/appointment_payment_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppointmentPaymentCubit extends Cubit<AppointmentPaymentState> {
  AppointmentPaymentCubit(this._repository, this._draftRepository)
    : super(const AppointmentPaymentState());

  final AppointmentRepository _repository;
  final AppointmentDraftRepository _draftRepository;

  Future<void> confirm({
    required AppointmentPaymentArguments arguments,
    required AppointmentPaymentRequest request,
    String? promoCode,
  }) async {
    if (state.isProcessing) return;
    emit(const AppointmentPaymentState(isProcessing: true));
    try {
      final appointment = await _repository.createAppointment(
        arguments: arguments,
        request: request,
        promoCode: promoCode,
      );
      await _draftRepository.deleteDraft();
      emit(AppointmentPaymentState(appointment: appointment));
    } on AppointmentException catch (error) {
      emit(AppointmentPaymentState(errorMessage: error.message));
    }
  }
}
