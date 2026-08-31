import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/booking_model.dart';
import 'package:multibook/src/data/repositories/review_repository.dart';
import 'package:multibook/src/domain/use_cases/bookings/customer_bookings_use_case.dart';
import 'package:multibook/src/features/customer-side/customer_booking_details/cubit/customer_booking_details_state.dart';
import 'package:multibook/src/features/shared/rate_business/domain/models/rate_business_target.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CustomerBookingDetailsCubit extends Cubit<CustomerBookingDetailsState> {
  CustomerBookingDetailsCubit(
    this._customerBookingsUseCase,
    this._reviewRepository,
    @factoryParam BookingModel booking,
  ) : super(CustomerBookingDetailsState(booking: booking));

  final CustomerBookingsUseCase _customerBookingsUseCase;
  final ReviewRepository _reviewRepository;

  Future<void> loadReviewStatus() async {
    try {
      final hasSubmittedReview = await _reviewRepository.hasReview(
        RateBusinessTarget.stay(
          businessId: state.booking.businessId,
          sourceId: state.booking.id,
          businessName: state.booking.businessName,
        ),
      );
      emit(state.copyWith(hasSubmittedReview: hasSubmittedReview));
    } catch (_) {}
  }

  void markReviewSubmitted() => emit(state.copyWith(hasSubmittedReview: true));

  Future<void> cancelBooking() async {
    emit(state.copyWith(isCancelling: true));
    final result = await _customerBookingsUseCase.cancelBooking(
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
