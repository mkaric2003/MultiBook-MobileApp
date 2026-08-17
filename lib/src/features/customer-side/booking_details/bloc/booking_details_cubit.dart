import 'package:aquabook/src/features/customer-side/booking_details/bloc/booking_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingDetailsCubit extends Cubit<BookingDetailsState> {
  BookingDetailsCubit() : super(BookingDetailsState.initial());

  void selectDate(DateTime date) {
    if (state.isSelectingCheckIn || !date.isAfter(state.checkIn)) {
      emit(
        state.copyWith(
          checkIn: date,
          checkOut: date.add(const Duration(days: 1)),
          isSelectingCheckIn: false,
        ),
      );
      return;
    }
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
}
