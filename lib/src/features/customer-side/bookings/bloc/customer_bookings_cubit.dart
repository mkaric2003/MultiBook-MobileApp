import 'package:aquabook/src/data/data_cursor.dart';
import 'package:aquabook/src/data/models/appointment_model.dart';
import 'package:aquabook/src/data/models/booking_model.dart';
import 'package:aquabook/src/data/repositories/appointment_repository.dart';
import 'package:aquabook/src/data/repositories/booking_repository.dart';
import 'package:aquabook/src/features/customer-side/bookings/bloc/customer_bookings_state.dart';
import 'package:aquabook/src/features/customer-side/bookings/domain/enums/customer_booking_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CustomerBookingsCubit extends Cubit<CustomerBookingsState> {
  CustomerBookingsCubit(this._bookingRepository, this._appointmentRepository)
    : super(const CustomerBookingsState());

  final BookingRepository _bookingRepository;
  final AppointmentRepository _appointmentRepository;
  DataCursor<BookingModel>? _cursor;
  DataCursor<AppointmentModel>? _appointmentCursor;

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
          appointments: state.appointments,
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
          appointments: state.appointments,
          isLoading: false,
          errorMessage: 'We could not load more bookings. Please try again.',
        ),
      );
    }
  }

  void selectType(CustomerBookingType type) {
    if (type == state.selectedType) return;
    if (type == CustomerBookingType.services && state.appointments.isEmpty) {
      _loadAppointments();
      return;
    }
    emit(
      CustomerBookingsState(
        selectedType: type,
        bookings: state.bookings,
        appointments: state.appointments,
        isLoading: false,
        hasReachedEnd: state.hasReachedEnd,
      ),
    );
  }

  Future<void> _loadAppointments() async {
    emit(
      CustomerBookingsState(
        selectedType: CustomerBookingType.services,
        bookings: state.bookings,
        appointments: state.appointments,
        isLoading: true,
      ),
    );
    try {
      _appointmentCursor = _appointmentRepository
          .getCustomerAppointmentsCursor();
      final appointments = await _appointmentRepository
          .enrichAppointmentsWithBusinessData(
            await _appointmentCursor!.fetchNextPage(),
          );
      emit(
        CustomerBookingsState(
          selectedType: CustomerBookingType.services,
          bookings: state.bookings,
          appointments: appointments,
          isLoading: false,
          hasReachedEnd: _appointmentCursor!.isEverythingLoaded,
        ),
      );
    } catch (_) {
      emit(
        CustomerBookingsState(
          selectedType: CustomerBookingType.services,
          bookings: state.bookings,
          isLoading: false,
          errorMessage:
              'We could not load your service bookings. Please try again.',
        ),
      );
    }
  }

  void updateBooking(BookingModel booking) {
    emit(
      CustomerBookingsState(
        selectedType: state.selectedType,
        bookings: state.bookings
            .map((current) => current.id == booking.id ? booking : current)
            .toList(),
        appointments: state.appointments,
        isLoading: false,
        hasReachedEnd: state.hasReachedEnd,
      ),
    );
  }

  void updateAppointment(AppointmentModel appointment) {
    emit(
      CustomerBookingsState(
        selectedType: state.selectedType,
        bookings: state.bookings,
        appointments: state.appointments
            .map(
              (current) => current.id == appointment.id ? appointment : current,
            )
            .toList(),
        isLoading: false,
        hasReachedEnd: state.hasReachedEnd,
      ),
    );
  }
}
