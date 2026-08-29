import 'package:multibook/src/data/data_cursor.dart';
import 'package:multibook/src/data/enums/booking_status.dart';
import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/data/repositories/appointment_repository.dart';
import 'package:multibook/src/data/models/booking_model.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/data/repositories/booking_repository.dart';
import 'package:multibook/src/data/repositories/business_repository.dart';
import 'package:multibook/src/data/repositories/user_repository.dart';
import 'package:multibook/src/features/business-side/bookings/bloc/client_bookings_state.dart';
import 'package:multibook/src/features/business-side/bookings/domain/enums/client_booking_filter.dart';
import 'package:multibook/src/features/business-side/bookings/domain/enums/client_bookings_tab.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ClientBookingsCubit extends Cubit<ClientBookingsState> {
  ClientBookingsCubit(
    this._bookingRepository,
    this._appointmentRepository,
    this._businessRepository,
    this._userRepository,
  ) : super(const ClientBookingsState());

  final BookingRepository _bookingRepository;
  final AppointmentRepository _appointmentRepository;
  final BusinessRepository _businessRepository;
  final UserRepository _userRepository;
  DataCursor<BookingModel>? _cursor;
  int _loadRequestId = 0;

  Future<void> load({
    ClientBookingFilter filter = ClientBookingFilter.all,
    String? businessId,
  }) async {
    final requestId = ++_loadRequestId;
    emit(
      ClientBookingsState(
        filter: filter,
        businesses: state.businesses,
        selectedBusiness: state.selectedBusiness,
        tab: state.tab,
      ),
    );

    try {
      final user = await _userRepository.getCurrentUser();
      final businesses = await _businessRepository.getOwnedBusinesses();
      final selectedBusiness =
          _findBusiness(businesses, businessId ?? user?.selectedBusinessId) ??
          (businesses.isEmpty ? null : businesses.first);

      if (selectedBusiness == null) {
        emit(ClientBookingsState(filter: filter, isLoading: false));
        return;
      }

      if (selectedBusiness.id != user?.selectedBusinessId) {
        await _userRepository.setSelectedBusiness(
          businessId: selectedBusiness.id,
        );
      }

      if (selectedBusiness.type == BusinessType.stays) {
        _cursor = _bookingRepository.getOwnedBookingsCursor(
          businessId: selectedBusiness.id,
          status: filter.bookingStatus,
        );
        final bookings = await _cursor!.fetchNextPage();
        if (requestId != _loadRequestId) return;
        emit(
          ClientBookingsState(
            filter: filter,
            bookings: bookings,
            businesses: businesses,
            selectedBusiness: selectedBusiness,
            tab: ClientBookingsTab.stays,
            isLoading: false,
            hasReachedEnd: _cursor!.isEverythingLoaded,
          ),
        );
        return;
      }
      _cursor = null;
      final appointments = await _getOwnedAppointments(
        businessId: selectedBusiness.id,
        filter: filter,
      );
      if (requestId != _loadRequestId) {
        return;
      }
      emit(
        ClientBookingsState(
          filter: filter,
          appointments: appointments,
          businesses: businesses,
          selectedBusiness: selectedBusiness,
          tab: ClientBookingsTab.services,
          isLoading: false,
          hasReachedEnd: true,
        ),
      );
    } on BookingException catch (error) {
      if (requestId != _loadRequestId) {
        return;
      }
      emit(
        ClientBookingsState(
          filter: filter,
          businesses: state.businesses,
          selectedBusiness: state.selectedBusiness,
          tab: state.tab,
          isLoading: false,
          errorMessage: error.message,
        ),
      );
    } catch (_) {
      if (requestId != _loadRequestId) {
        return;
      }
      emit(
        ClientBookingsState(
          filter: filter,
          businesses: state.businesses,
          selectedBusiness: state.selectedBusiness,
          tab: state.tab,
          isLoading: false,
          errorMessage: 'We could not load bookings. Please try again.',
        ),
      );
    }
  }

  Future<List<AppointmentModel>> _getOwnedAppointments({
    required String businessId,
    required ClientBookingFilter filter,
  }) async {
    final cursor = _appointmentRepository.getOwnedAppointmentsCursor(
      businessId: businessId,
      status: filter == ClientBookingFilter.all ? null : filter.name,
    );
    final appointments = <AppointmentModel>[];
    while (!cursor.isEverythingLoaded) {
      appointments.addAll(await cursor.fetchNextPage());
    }
    return appointments;
  }

  Future<void> loadMore() async {
    final cursor = _cursor;
    if (cursor == null || state.isLoadingMore || cursor.isEverythingLoaded) {
      return;
    }

    emit(
      ClientBookingsState(
        filter: state.filter,
        bookings: state.bookings,
        businesses: state.businesses,
        selectedBusiness: state.selectedBusiness,
        tab: state.tab,
        isLoading: false,
        isLoadingMore: true,
      ),
    );

    try {
      final nextPage = await cursor.fetchNextPage();
      if (cursor != _cursor) {
        return;
      }
      emit(
        ClientBookingsState(
          filter: state.filter,
          bookings: [...state.bookings, ...nextPage],
          businesses: state.businesses,
          selectedBusiness: state.selectedBusiness,
          tab: state.tab,
          isLoading: false,
          hasReachedEnd: cursor.isEverythingLoaded,
        ),
      );
    } catch (_) {
      if (cursor != _cursor) {
        return;
      }
      emit(
        ClientBookingsState(
          filter: state.filter,
          bookings: state.bookings,
          businesses: state.businesses,
          selectedBusiness: state.selectedBusiness,
          tab: state.tab,
          isLoading: false,
          errorMessage: 'We could not load more bookings. Please try again.',
        ),
      );
    }
  }

  Future<void> selectBusiness(BusinessModel business) async {
    if (business.id == state.selectedBusiness?.id) {
      return;
    }

    await _userRepository.setSelectedBusiness(businessId: business.id);
    await load(filter: state.filter, businessId: business.id);
  }

  Future<bool> declineBooking(BookingModel booking) async {
    try {
      await _bookingRepository.declineBooking(bookingId: booking.id);
      final declinedBooking = booking.copyWith(status: BookingStatus.declined);
      final updatedBookings =
          state.filter == ClientBookingFilter.all ||
              state.filter == ClientBookingFilter.declined
          ? state.bookings
                .map(
                  (currentBooking) => currentBooking.id == booking.id
                      ? declinedBooking
                      : currentBooking,
                )
                .toList()
          : state.bookings
                .where((currentBooking) => currentBooking.id != booking.id)
                .toList();
      emit(
        ClientBookingsState(
          filter: state.filter,
          bookings: updatedBookings,
          businesses: state.businesses,
          selectedBusiness: state.selectedBusiness,
          tab: state.tab,
          isLoading: false,
          hasReachedEnd: state.hasReachedEnd,
        ),
      );
      return true;
    } on BookingException {
      return false;
    }
  }

  Future<bool> completeBooking(BookingModel booking) async {
    try {
      final completed = await _bookingRepository.completeBooking(booking);
      _replaceBooking(completed);
      return true;
    } on BookingException {
      return false;
    }
  }

  Future<bool> markBookingNoShow(BookingModel booking) async {
    try {
      final noShow = await _bookingRepository.markBookingNoShow(booking);
      _replaceBooking(noShow);
      return true;
    } on BookingException {
      return false;
    }
  }

  Future<bool> declineAppointment(AppointmentModel appointment) async {
    try {
      final declined = await _appointmentRepository.cancelAppointment(
        appointment,
      );
      _replaceAppointment(declined);
      return true;
    } on AppointmentException {
      return false;
    }
  }

  Future<bool> completeAppointment(AppointmentModel appointment) async {
    try {
      final completed = await _appointmentRepository.completeAppointment(
        appointment,
      );
      _replaceAppointment(completed);
      return true;
    } on AppointmentException {
      return false;
    }
  }

  Future<bool> markAppointmentNoShow(AppointmentModel appointment) async {
    try {
      final noShow = await _appointmentRepository.markAppointmentNoShow(
        appointment,
      );
      _replaceAppointment(noShow);
      return true;
    } on AppointmentException {
      return false;
    }
  }

  void _replaceBooking(BookingModel booking) {
    final bookings =
        state.filter == ClientBookingFilter.all ||
            state.filter.bookingStatus == booking.status
        ? state.bookings
              .map((item) => item.id == booking.id ? booking : item)
              .toList()
        : state.bookings.where((item) => item.id != booking.id).toList();
    emit(
      ClientBookingsState(
        filter: state.filter,
        bookings: bookings,
        businesses: state.businesses,
        selectedBusiness: state.selectedBusiness,
        tab: state.tab,
        isLoading: false,
        hasReachedEnd: state.hasReachedEnd,
      ),
    );
  }

  void updateAppointment(AppointmentModel appointment) {
    _replaceAppointment(appointment);
  }

  void _replaceAppointment(AppointmentModel appointment) {
    final appointments =
        state.filter == ClientBookingFilter.all ||
            state.filter.name == appointment.status
        ? state.appointments
              .map((item) => item.id == appointment.id ? appointment : item)
              .toList()
        : state.appointments
              .where((item) => item.id != appointment.id)
              .toList();
    emit(
      ClientBookingsState(
        filter: state.filter,
        appointments: appointments,
        businesses: state.businesses,
        selectedBusiness: state.selectedBusiness,
        tab: state.tab,
        isLoading: false,
        hasReachedEnd: state.hasReachedEnd,
      ),
    );
  }

  BusinessModel? _findBusiness(
    List<BusinessModel> businesses,
    String? businessId,
  ) {
    for (final business in businesses) {
      if (business.id == businessId) {
        return business;
      }
    }
    return null;
  }
}
