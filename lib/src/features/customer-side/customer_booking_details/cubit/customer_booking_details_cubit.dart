import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/booking_model.dart';
import 'package:multibook/src/domain/use_cases/bookings/cancel_customer_booking_use_case.dart';
import 'package:multibook/src/domain/use_cases/reviews/has_business_review_use_case.dart';
import 'package:multibook/src/features/customer-side/customer_booking_details/cubit/customer_booking_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CustomerBookingDetailsCubit extends Cubit<CustomerBookingDetailsState> {
  CustomerBookingDetailsCubit(
    this._cancelCustomerBookingUseCase,
    this._hasBusinessReview,
    @factoryParam BookingModel booking,
  ) : super(CustomerBookingDetailsState(booking: booking));

  final CancelCustomerBookingUseCase _cancelCustomerBookingUseCase;
  final HasBusinessReviewUseCase _hasBusinessReview;

  Future<void> loadReviewStatus() async {
    final result = await _hasBusinessReview.execute(state.booking.businessId);
    if (result case Success<bool>(value: final hasSubmittedReview)) {
      emit(state.copyWith(hasSubmittedReview: hasSubmittedReview));
    }
  }

  void markReviewSubmitted() => emit(state.copyWith(hasSubmittedReview: true));

  Future<void> cancelBooking() async {
    emit(state.copyWith(isCancelling: true));
    final result = await _cancelCustomerBookingUseCase.execute(
      state.booking.id,
    );
    if (result is Success<BookingModel>) {
      emit(state.copyWith(booking: result.value, isCancelling: false));
      return;
    }
    emit(
      state.copyWith(
        isCancelling: false,
        errorMessage: 'We could not cancel this booking. Please try again.',
      ),
    );
  }
}
