import 'package:multibook/src/data/models/booking_draft_model.dart';
import 'package:multibook/src/data/models/stay_availability_response.dart';
import 'package:multibook/src/data/models/stay_unavailable_range.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/use_cases/bookings/get_stay_availability_use_case.dart';
import 'package:multibook/src/domain/use_cases/drafts/save_booking_draft_use_case.dart';
import 'package:multibook/src/features/customer-side/booking_details/domain/models/booking_details_arguments.dart';
import 'package:multibook/src/features/customer-side/booking_details/bloc/booking_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class BookingDetailsCubit extends Cubit<BookingDetailsState> {
  BookingDetailsCubit(
    this._getStayAvailabilityUseCase,
    this._saveBookingDraftUseCase,
  ) : super(BookingDetailsState.initial());

  final GetStayAvailabilityUseCase _getStayAvailabilityUseCase;
  final SaveBookingDraftUseCase _saveBookingDraftUseCase;

  void restoreDraft(BookingDraftModel draft) => emit(
    state.copyWith(
      checkIn: draft.checkIn,
      checkOut: draft.checkOut,
      visibleMonth: DateTime(draft.checkIn.year, draft.checkIn.month),
      adults: draft.adults,
      children: draft.children,
      infants: draft.infants,
    ),
  );

  Future<void> saveDraft(BookingDetailsArguments arguments) =>
      _saveBookingDraftUseCase.execute(
        BookingDraftModel(
          id: '',
          businessId: arguments.stay.id,
          businessName: arguments.stay.name,
          businessLocation: arguments.stay.location,
          businessImageUrl: arguments.stay.imageUrl,
          pricePerNight:
              arguments.pricePerNight ?? arguments.stay.pricePerNight ?? 0,
          checkIn: state.checkIn,
          checkOut: state.checkOut,
          adults: state.adults,
          children: state.children,
          infants: state.infants,
          roomTypeId: arguments.room?.id,
        ),
      );

  Future<void> loadAvailability({
    required String businessId,
    String? roomTypeId,
  }) async {
    emit(state.copyWith(isLoadingAvailability: true));
    final result = await _getStayAvailabilityUseCase.execute(
      businessId: businessId,
      roomTypeId: roomTypeId,
    );
    if (result is Success<StayAvailabilityResponse>) {
      final unavailableDates = _unavailableDates(
        result.value.unavailableRanges,
      );
      final checkIn = _nextAvailableDate(state.checkIn, unavailableDates);
      final canRestoreRange =
          _sameDay(checkIn, state.checkIn) &&
          state.checkOut.isAfter(checkIn) &&
          !_hasUnavailableDateBetween(checkIn, state.checkOut);
      final checkOut = canRestoreRange
          ? state.checkOut
          : _nextAvailableDate(
              checkIn.add(const Duration(days: 1)),
              unavailableDates,
            );
      emit(
        state.copyWith(
          unavailableDates: unavailableDates,
          checkIn: checkIn,
          checkOut: checkOut,
          visibleMonth: DateTime(checkIn.year, checkIn.month),
          isLoadingAvailability: false,
        ),
      );
      return;
    }
    emit(state.copyWith(isLoadingAvailability: false));
  }

  void selectDate(DateTime date) {
    if (_isUnavailable(date)) return;
    if (state.isSelectingCheckIn || !date.isAfter(state.checkIn)) {
      final checkOut = _nextAvailableDate(
        date.add(const Duration(days: 1)),
        state.unavailableDates,
      );
      emit(
        state.copyWith(
          checkIn: date,
          checkOut: checkOut,
          isSelectingCheckIn: false,
        ),
      );
      return;
    }
    if (_hasUnavailableDateBetween(state.checkIn, date)) return;
    emit(state.copyWith(checkOut: date, isSelectingCheckIn: true));
  }

  void showPreviousMonth() {
    emit(
      state.copyWith(
        visibleMonth: DateTime(
          state.visibleMonth.year,
          state.visibleMonth.month - 1,
        ),
      ),
    );
  }

  void showNextMonth() {
    emit(
      state.copyWith(
        visibleMonth: DateTime(
          state.visibleMonth.year,
          state.visibleMonth.month + 1,
        ),
      ),
    );
  }

  void changeAdults(int delta) {
    emit(state.copyWith(adults: (state.adults + delta).clamp(1, 20)));
  }

  void changeChildren(int delta) {
    emit(state.copyWith(children: (state.children + delta).clamp(0, 20)));
  }

  void changeInfants(int delta) {
    emit(state.copyWith(infants: (state.infants + delta).clamp(0, 20)));
  }

  Set<DateTime> _unavailableDates(List<StayUnavailableRange> ranges) {
    final dates = <DateTime>{};
    for (final range in ranges) {
      var date = _dateOnly(range.checkIn);
      final checkOut = _dateOnly(range.checkOut);
      while (date.isBefore(checkOut)) {
        dates.add(date);
        date = date.add(const Duration(days: 1));
      }
    }
    return dates;
  }

  DateTime _nextAvailableDate(DateTime from, Set<DateTime> unavailableDates) {
    var date = _dateOnly(from);
    while (_isUnavailableDate(date, unavailableDates)) {
      date = date.add(const Duration(days: 1));
    }
    return date;
  }

  bool _hasUnavailableDateBetween(DateTime start, DateTime end) {
    var date = _dateOnly(start);
    final lastDate = _dateOnly(end);
    while (!date.isAfter(lastDate)) {
      if (_isUnavailable(date)) return true;
      date = date.add(const Duration(days: 1));
    }
    return false;
  }

  bool _isUnavailable(DateTime date) =>
      _isUnavailableDate(date, state.unavailableDates);

  bool _isUnavailableDate(DateTime date, Set<DateTime> unavailableDates) =>
      unavailableDates.any((item) => _sameDay(item, date));

  DateTime _dateOnly(DateTime value) =>
      DateTime(value.year, value.month, value.day);

  bool _sameDay(DateTime first, DateTime second) =>
      first.year == second.year &&
      first.month == second.month &&
      first.day == second.day;
}
