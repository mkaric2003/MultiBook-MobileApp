import 'package:multibook/src/data/models/stay_extra_model.dart';
import 'package:multibook/src/data/repositories/business_repository.dart';
import 'package:multibook/src/data/repositories/booking_draft_repository.dart';
import 'package:multibook/src/data/models/booking_draft_model.dart';
import 'package:multibook/src/features/customer-side/review_stay/domain/models/review_stay_arguments.dart';
import 'package:multibook/src/features/customer-side/review_stay/cubit/review_stay_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ReviewStayCubit extends Cubit<ReviewStayState> {
  ReviewStayCubit(this._repository, this._draftRepository)
    : super(const ReviewStayState());

  final BusinessRepository _repository;
  final BookingDraftRepository _draftRepository;

  Future<void> loadStay(
    String id, {
    List<StayExtraModel> selectedExtras = const [],
  }) async {
    emit(state.copyWith(isLoading: true));
    final business = await _repository.getBusiness(businessId: id);
    emit(
      state.copyWith(
        isLoading: false,
        business: business,
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
      _draftRepository.saveDraft(
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
