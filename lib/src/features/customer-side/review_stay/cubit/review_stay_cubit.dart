import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/stay_extra_model.dart';
import 'package:multibook/src/data/models/booking_draft_model.dart';
import 'package:multibook/src/domain/use_cases/customer_discovery/get_business_detail_use_case.dart';
import 'package:multibook/src/domain/use_cases/drafts/customer_drafts_use_case.dart';
import 'package:multibook/src/features/customer-side/review_stay/domain/models/review_stay_arguments.dart';
import 'package:multibook/src/features/customer-side/review_stay/cubit/review_stay_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ReviewStayCubit extends Cubit<ReviewStayState> {
  ReviewStayCubit(this._getBusinessDetail, this._customerDraftsUseCase)
    : super(const ReviewStayState());

  final GetBusinessDetailUseCase _getBusinessDetail;
  final CustomerDraftsUseCase _customerDraftsUseCase;

  Future<void> loadStay(
    String id, {
    List<StayExtraModel> selectedExtras = const [],
  }) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    final result = await _getBusinessDetail.execute(id);
    if (isClosed) return;
    emit(
      state.copyWith(
        isLoading: false,
        business: switch (result) {
          Success(value: final business) => business,
          FailureResult() => null,
        },
        errorMessage: result is FailureResult
            ? 'We could not load this stay. Please try again.'
            : null,
        selectedExtras: selectedExtras,
      ),
    );
  }

  void toggleExtra(StayExtraModel extra) {
    final extras = [...state.selectedExtras];
    extras.contains(extra) ? extras.remove(extra) : extras.add(extra);
    emit(state.copyWith(selectedExtras: extras));
  }

  Future<void> saveDraft(ReviewStayArguments arguments) =>
      _customerDraftsUseCase.saveBookingDraft(
        BookingDraftModel(
          id: '',
          businessId: arguments.booking.stay.id,
          businessName: arguments.booking.stay.name,
          businessLocation: arguments.booking.stay.location,
          businessImageUrl: arguments.booking.stay.imageUrl,
          pricePerNight:
              arguments.booking.pricePerNight ??
              arguments.booking.stay.pricePerNight ??
              0,
          checkIn: arguments.bookingState.checkIn,
          checkOut: arguments.bookingState.checkOut,
          adults: arguments.bookingState.adults,
          children: arguments.bookingState.children,
          infants: arguments.bookingState.infants,
          roomTypeId: arguments.booking.room?.id,
          selectedExtras: state.selectedExtras,
        ),
      );
}
