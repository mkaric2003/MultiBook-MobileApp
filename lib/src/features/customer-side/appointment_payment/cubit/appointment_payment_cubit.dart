import 'package:multibook/src/domain/use_cases/checkout/create_customer_appointment_use_case.dart';
import 'package:multibook/src/domain/use_cases/drafts/delete_appointment_draft_use_case.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/create_appointment_request.dart';
import 'package:multibook/src/features/customer-side/appointment_payment/cubit/appointment_payment_state.dart';
import 'package:multibook/src/features/customer-side/appointment_payment/domain/models/appointment_payment_arguments.dart';
import 'package:multibook/src/features/customer-side/appointment_payment/domain/models/appointment_payment_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppointmentPaymentCubit extends Cubit<AppointmentPaymentState> {
  AppointmentPaymentCubit(
    this._createCustomerAppointmentUseCase,
    this._deleteAppointmentDraftUseCase,
  ) : super(const AppointmentPaymentState());

  final CreateCustomerAppointmentUseCase _createCustomerAppointmentUseCase;
  final DeleteAppointmentDraftUseCase _deleteAppointmentDraftUseCase;

  Future<void> confirm({
    required AppointmentPaymentArguments arguments,
    required AppointmentPaymentRequest request,
    String? promoCode,
  }) async {
    if (state.isProcessing) return;
    emit(const AppointmentPaymentState(isProcessing: true));
    try {
      final review = arguments.review;
      final appointmentResult = await _createCustomerAppointmentUseCase.execute(
        review.business.id,
        CreateAppointmentRequest(
          staffId: review.provider.id,
          appointmentDate: _date(review.date),
          startMinutes: review.startMinutes,
          offeringIds: review.offerings.map((offering) => offering.id).toList(),
          customerName: request.customerName,
          customerEmail: request.customerEmail,
          customerPhone: request.customerPhone,
          paymentMethod: request.paymentMethod,
          promoCode: promoCode?.trim().isEmpty == true
              ? null
              : promoCode?.trim(),
        ),
      );
      if (appointmentResult is FailureResult) {
        emit(
          const AppointmentPaymentState(
            errorMessage:
                'We could not confirm your appointment. Please try again.',
          ),
        );
        return;
      }
      final appointment = (appointmentResult as Success).value;
      await _deleteAppointmentDraftUseCase.execute();
      emit(AppointmentPaymentState(appointment: appointment));
    } catch (_) {
      emit(
        const AppointmentPaymentState(
          errorMessage:
              'We could not confirm your appointment. Please try again.',
        ),
      );
    }
  }

  String _date(DateTime value) =>
      '${value.year.toString().padLeft(4, '0')}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';
}
