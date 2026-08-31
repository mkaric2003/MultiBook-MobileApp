import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/data/models/appointment_list_response.dart';
import 'package:multibook/src/data/models/booking_list_response.dart';
import 'package:multibook/src/data/models/booking_model.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/use_cases/appointments/get_customer_appointments_use_case.dart';
import 'package:multibook/src/domain/use_cases/bookings/get_customer_bookings_use_case.dart';
import 'package:multibook/src/features/customer-side/bookings/bloc/customer_bookings_state.dart';
import 'package:multibook/src/features/customer-side/bookings/domain/enums/customer_booking_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CustomerBookingsCubit extends Cubit<CustomerBookingsState> {
  CustomerBookingsCubit(
    this._getCustomerBookingsUseCase,
    this._getCustomerAppointmentsUseCase,
  ) : super(const CustomerBookingsState());

  final GetCustomerBookingsUseCase _getCustomerBookingsUseCase;
  final GetCustomerAppointmentsUseCase _getCustomerAppointmentsUseCase;
  String? _nextBookingCursor;
  String? _nextAppointmentCursor;

  Future<void> load() async {
    emit(const CustomerBookingsState());
    _nextBookingCursor = null;
    final result = await _getCustomerBookingsUseCase.execute();
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
    if (state.selectedType == CustomerBookingType.services) {
      await _loadMoreAppointments();
      return;
    }
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
    final result = await _getCustomerBookingsUseCase.execute(cursor: cursor);
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
    _nextAppointmentCursor = null;
    emit(
      CustomerBookingsState(
        selectedType: CustomerBookingType.services,
        bookings: state.bookings,
        appointments: state.appointments,
        isLoading: true,
      ),
    );
    final result = await _getCustomerAppointmentsUseCase.execute();
    if (result is Success<AppointmentListResponse>) {
      _nextAppointmentCursor = result.value.nextCursor;
      emit(
        CustomerBookingsState(
          selectedType: CustomerBookingType.services,
          bookings: state.bookings,
          appointments: result.value.items,
          isLoading: false,
          hasReachedEnd: result.value.nextCursor == null,
        ),
      );
      return;
    }
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

  Future<void> _loadMoreAppointments() async {
    final cursor = _nextAppointmentCursor;
    if (cursor == null || state.isLoadingMore) {
      return;
    }
    emit(
      CustomerBookingsState(
        selectedType: CustomerBookingType.services,
        bookings: state.bookings,
        appointments: state.appointments,
        isLoading: false,
        isLoadingMore: true,
      ),
    );
    final result = await _getCustomerAppointmentsUseCase.execute(
      cursor: cursor,
    );
    if (cursor != _nextAppointmentCursor) return;
    if (result is Success<AppointmentListResponse>) {
      final page = result.value;
      _nextAppointmentCursor = page.nextCursor;
      emit(
        CustomerBookingsState(
          selectedType: CustomerBookingType.services,
          bookings: state.bookings,
          appointments: [...state.appointments, ...page.items],
          isLoading: false,
          hasReachedEnd: page.nextCursor == null,
        ),
      );
      return;
    }
    emit(
      CustomerBookingsState(
        selectedType: CustomerBookingType.services,
        bookings: state.bookings,
        appointments: state.appointments,
        isLoading: false,
        errorMessage:
            'We could not load more service bookings. Please try again.',
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
