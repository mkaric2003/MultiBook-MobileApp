import 'package:multibook/src/data/data_cursor.dart';
import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/data/models/booking_list_response.dart';
import 'package:multibook/src/data/models/booking_model.dart';
import 'package:multibook/src/data/repositories/appointment_repository.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/use_cases/bookings/customer_bookings_use_case.dart';
import 'package:multibook/src/features/customer-side/bookings/bloc/customer_bookings_state.dart';
import 'package:multibook/src/features/customer-side/bookings/domain/enums/customer_booking_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CustomerBookingsCubit extends Cubit<CustomerBookingsState> {
  CustomerBookingsCubit(
    this._customerBookingsUseCase,
    this._appointmentRepository,
  ) : super(const CustomerBookingsState());

  final CustomerBookingsUseCase _customerBookingsUseCase;
  final AppointmentRepository _appointmentRepository;
  DataCursor<AppointmentModel>? _appointmentCursor;
  String? _nextBookingCursor;

  Future<void> load() async {
    emit(const CustomerBookingsState());
    _nextBookingCursor = null;
    final result = await _customerBookingsUseCase.getBookings();
    if (result is Success<BookingListResponse>) {
      final page = result.value;
      _nextBookingCursor = page.nextCursor;
      emit(
        CustomerBookingsState(
          bookings: page.items,
          isLoading: false,
          hasReachedEnd: page.nextCursor == null,
        ),
      );
      return;
    }
    emit(
      const CustomerBookingsState(
        isLoading: false,
        errorMessage: 'We could not load your bookings. Please try again.',
      ),
    );
  }

  Future<void> loadMore() async {
    final cursor = _nextBookingCursor;
    if (cursor == null || state.isLoadingMore) {
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
    final result = await _customerBookingsUseCase.getBookings(cursor: cursor);
    if (cursor != _nextBookingCursor) return;
    if (result is Success<BookingListResponse>) {
      final page = result.value;
      _nextBookingCursor = page.nextCursor;
      emit(
        CustomerBookingsState(
          selectedType: state.selectedType,
          bookings: [...state.bookings, ...page.items],
          appointments: state.appointments,
          isLoading: false,
          hasReachedEnd: page.nextCursor == null,
        ),
      );
      return;
    }
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
