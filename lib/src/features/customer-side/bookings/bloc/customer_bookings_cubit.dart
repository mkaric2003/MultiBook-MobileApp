import 'package:aquabook/src/data/data_cursor.dart';
import 'package:aquabook/src/data/models/booking_model.dart';
import 'package:aquabook/src/data/repositories/booking_repository.dart';
import 'package:aquabook/src/features/customer-side/bookings/bloc/customer_bookings_state.dart';
import 'package:aquabook/src/features/customer-side/bookings/domain/enums/customer_booking_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CustomerBookingsCubit extends Cubit<CustomerBookingsState> {
  CustomerBookingsCubit(this._bookingRepository)
    : super(const CustomerBookingsState());

  final BookingRepository _bookingRepository;
  DataCursor<BookingModel>? _cursor;

  Future<void> load() async {
    emit(const CustomerBookingsState());
    try {
      _cursor = _bookingRepository.getCustomerBookingsCursor();
      final bookings = await _cursor!.fetchNextPage();
      emit(
        CustomerBookingsState(
          bookings: bookings,
          isLoading: false,
          hasReachedEnd: _cursor!.isEverythingLoaded,
        ),
      );
    } catch (_) {
      emit(
        const CustomerBookingsState(
          isLoading: false,
          errorMessage: 'We could not load your bookings. Please try again.',
        ),
      );
    }
  }

  Future<void> loadMore() async {
    final cursor = _cursor;
    if (cursor == null || state.isLoadingMore || cursor.isEverythingLoaded) {
      return;
    }
    emit(
      CustomerBookingsState(
        selectedType: state.selectedType,
        bookings: state.bookings,
        isLoading: false,
        isLoadingMore: true,
      ),
    );
    try {
      final nextPage = await cursor.fetchNextPage();
      if (cursor != _cursor) return;
      emit(
        CustomerBookingsState(
          selectedType: state.selectedType,
          bookings: [...state.bookings, ...nextPage],
          isLoading: false,
          hasReachedEnd: cursor.isEverythingLoaded,
        ),
      );
    } catch (_) {
      if (cursor != _cursor) return;
      emit(
        CustomerBookingsState(
          selectedType: state.selectedType,
          bookings: state.bookings,
          isLoading: false,
          errorMessage: 'We could not load more bookings. Please try again.',
        ),
      );
    }
  }

  void selectType(CustomerBookingType type) {
    if (type == state.selectedType) return;
    emit(
      CustomerBookingsState(
        selectedType: type,
        bookings: state.bookings,
        isLoading: false,
        hasReachedEnd: state.hasReachedEnd,
      ),
    );
  }

  void updateBooking(BookingModel booking) {
    emit(
      CustomerBookingsState(
        selectedType: state.selectedType,
        bookings: state.bookings
            .map((current) => current.id == booking.id ? booking : current)
            .toList(),
        isLoading: false,
        hasReachedEnd: state.hasReachedEnd,
      ),
    );
  }
}
