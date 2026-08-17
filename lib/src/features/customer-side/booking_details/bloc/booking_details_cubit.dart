import 'package:aquabook/src/data/enums/booking_status.dart';
import 'package:aquabook/src/data/models/booking_model.dart';
import 'package:aquabook/src/data/repositories/booking_repository.dart';
import 'package:aquabook/src/features/customer-side/booking_details/bloc/booking_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class BookingDetailsCubit extends Cubit<BookingDetailsState> {
  BookingDetailsCubit(this._bookingRepository)
    : super(BookingDetailsState.initial());

  final BookingRepository _bookingRepository;

  Future<void> loadAvailability(String businessId) async {
    emit(state.copyWith(isLoadingAvailability: true));
    try {
      final bookings = await _bookingRepository.getCustomerBusinessBookings(
        businessId: businessId,
      );
      final unavailableDates = _unavailableDates(bookings);
      final checkIn = _nextAvailableDate(state.checkIn, unavailableDates);
      final checkOut = _nextAvailableDate(
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
    } catch (_) {
      emit(state.copyWith(isLoadingAvailability: false));
    }
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

  Set<DateTime> _unavailableDates(List<BookingModel> bookings) {
    final dates = <DateTime>{};
    for (final booking in bookings) {
      if (booking.status != BookingStatus.confirmed &&
          booking.status != BookingStatus.completed) {
        continue;
      }
      var date = _dateOnly(booking.checkIn);
      final checkOut = _dateOnly(booking.checkOut);
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
