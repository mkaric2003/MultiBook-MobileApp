import 'package:multibook/src/data/enums/booking_status.dart';
import 'package:multibook/src/data/models/booking_model.dart';
import 'package:multibook/src/data/repositories/booking_repository.dart';
import 'package:multibook/src/data/repositories/review_repository.dart';
import 'package:multibook/src/features/customer-side/customer_booking_details/cubit/customer_booking_details_state.dart';
import 'package:multibook/src/features/shared/rate_business/domain/models/rate_business_target.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CustomerBookingDetailsCubit extends Cubit<CustomerBookingDetailsState> {
  CustomerBookingDetailsCubit(
    this._bookingRepository,
    this._reviewRepository,
    @factoryParam BookingModel booking,
  ) : super(CustomerBookingDetailsState(booking: booking));

  final BookingRepository _bookingRepository;
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
    try {
      await _bookingRepository.cancelBooking(bookingId: state.booking.id);
      emit(
        state.copyWith(
          booking: state.booking.copyWith(status: BookingStatus.cancelled),
          isCancelling: false,
        ),
      );
    } on BookingException catch (error) {
      emit(state.copyWith(isCancelling: false, errorMessage: error.message));
    }
  }
}
