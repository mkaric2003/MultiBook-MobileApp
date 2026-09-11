import 'package:multibook/src/data/enums/payment_method_type.dart';
import 'package:multibook/src/domain/use_cases/checkout/create_customer_booking_use_case.dart';
import 'package:multibook/src/domain/use_cases/drafts/delete_booking_draft_use_case.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/booking_extra_request.dart';
import 'package:multibook/src/data/models/create_booking_request.dart';
import 'package:multibook/src/features/customer-side/payment/cubit/payment_state.dart';
import 'package:multibook/src/features/customer-side/payment/domain/models/payment_arguments.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(
    this._createCustomerBookingUseCase,
    this._deleteBookingDraftUseCase,
  ) : super(const PaymentState());
  final CreateCustomerBookingUseCase _createCustomerBookingUseCase;
  final DeleteBookingDraftUseCase _deleteBookingDraftUseCase;
  Future<void> confirm(
    PaymentArguments arguments, {
    required PaymentMethodType paymentType,
    required String paymentMethod,
    required String customerName,
    required String customerEmail,
    String? promoCode,
  }) async {
    if (state.isProcessing) return;
    emit(const PaymentState(isProcessing: true));
    try {
      final state = arguments.review.bookingState;
      final bookingResult = await _createCustomerBookingUseCase.execute(
        arguments.review.booking.stay.id,
        CreateBookingRequest(
          stayUnitTypeId: arguments.review.booking.room?.id,
          checkIn: _date(state.checkIn),
          checkOut: _date(state.checkOut),
          adults: state.adults,
          children: state.children,
          infants: state.infants,
          selectedExtras: arguments.selectedExtras
              .map((extra) => BookingExtraRequest(type: extra.type.name))
              .toList(),
          customerName: customerName,
          customerEmail: customerEmail,
          paymentMethod: paymentMethod,
          promoCode: promoCode?.trim().isEmpty == true
              ? null
              : promoCode?.trim(),
        ),
      );
      if (bookingResult is FailureResult) {
        emit(
          const PaymentState(
            errorMessage:
                'We could not complete your booking. Please try again.',
          ),
        );
        return;
      }
      final booking = (bookingResult as Success).value;
      await _deleteBookingDraftUseCase.execute();
      emit(PaymentState(booking: booking));
    } catch (_) {
      emit(
        const PaymentState(
          errorMessage: 'We could not complete your booking. Please try again.',
        ),
      );
    }
  }

  String _date(DateTime value) =>
      '${value.year.toString().padLeft(4, '0')}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';
}
