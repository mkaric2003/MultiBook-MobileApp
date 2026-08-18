import 'package:aquabook/src/data/repositories/booking_repository.dart';
import 'package:aquabook/src/data/repositories/booking_draft_repository.dart';
import 'package:aquabook/src/features/customer-side/payment/cubit/payment_state.dart';
import 'package:aquabook/src/features/customer-side/payment/domain/models/payment_arguments.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this._repository, this._draftRepository)
    : super(const PaymentState());
  final BookingRepository _repository;
  final BookingDraftRepository _draftRepository;
  Future<void> confirm(PaymentArguments arguments) async {
    if (state.isProcessing) return;
    emit(const PaymentState(isProcessing: true));
    try {
      final booking = await _repository.createBooking(arguments);
      await _draftRepository.deleteDraft();
      emit(PaymentState(booking: booking));
    } on BookingException catch (error) {
      emit(PaymentState(errorMessage: error.message));
    }
  }
}
