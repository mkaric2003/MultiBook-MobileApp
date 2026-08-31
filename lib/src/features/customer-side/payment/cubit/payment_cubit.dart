import 'package:multibook/src/data/enums/payment_method_type.dart';
import 'package:multibook/src/data/repositories/booking_repository.dart';
import 'package:multibook/src/domain/use_cases/drafts/customer_drafts_use_case.dart';
import 'package:multibook/src/features/customer-side/payment/cubit/payment_state.dart';
import 'package:multibook/src/features/customer-side/payment/domain/models/payment_arguments.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this._repository, this._customerDraftsUseCase)
    : super(const PaymentState());
  final BookingRepository _repository;
  final CustomerDraftsUseCase _customerDraftsUseCase;
  Future<void> confirm(
    PaymentArguments arguments, {
    required PaymentMethodType paymentType,
    required String paymentMethod,
    String? promoCode,
  }) async {
    if (state.isProcessing) return;
    emit(const PaymentState(isProcessing: true));
    try {
      final booking = await _repository.createBooking(
        arguments,
        paymentType: paymentType,
        paymentMethod: paymentMethod,
        promoCode: promoCode,
      );
      await _customerDraftsUseCase.deleteBookingDraft();
      emit(PaymentState(booking: booking));
    } on BookingException catch (error) {
      emit(PaymentState(errorMessage: error.message));
    }
  }
}
