import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/data/models/appointment_list_response.dart';
import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/data/models/booking_list_response.dart';
import 'package:multibook/src/data/models/booking_model.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/use_cases/businesses/get_owned_businesses_use_case.dart';
import 'package:multibook/src/domain/use_cases/provider_bookings/get_provider_appointments_use_case.dart';
import 'package:multibook/src/domain/use_cases/provider_bookings/get_provider_bookings_use_case.dart';
import 'package:multibook/src/domain/use_cases/provider_bookings/update_provider_appointment_status_use_case.dart';
import 'package:multibook/src/domain/use_cases/provider_bookings/update_provider_booking_status_use_case.dart';
import 'package:multibook/src/domain/use_cases/users/user_profile_use_case.dart';
import 'package:multibook/src/features/business-side/bookings/bloc/client_bookings_state.dart';
import 'package:multibook/src/features/business-side/bookings/domain/enums/client_booking_filter.dart';
import 'package:multibook/src/features/business-side/bookings/domain/enums/client_bookings_tab.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ClientBookingsCubit extends Cubit<ClientBookingsState> {
  ClientBookingsCubit(
    this._getProviderBookingsUseCase,
    this._getProviderAppointmentsUseCase,
    this._updateProviderBookingStatusUseCase,
    this._updateProviderAppointmentStatusUseCase,
    this._getOwnedBusinessesUseCase,
    this._userRepository,
  ) : super(const ClientBookingsState());

  final GetProviderBookingsUseCase _getProviderBookingsUseCase;
  final GetProviderAppointmentsUseCase _getProviderAppointmentsUseCase;
  final UpdateProviderBookingStatusUseCase _updateProviderBookingStatusUseCase;
  final UpdateProviderAppointmentStatusUseCase
  _updateProviderAppointmentStatusUseCase;
  final GetOwnedBusinessesUseCase _getOwnedBusinessesUseCase;
  final UserProfileUseCase _userRepository;
  String? _nextBookingCursor;
  String? _nextAppointmentCursor;
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
      final businessesResult = await _getOwnedBusinessesUseCase.execute();
      if (businessesResult is! Success<List<BusinessModel>>) throw Exception();
      final businesses = businessesResult.value;
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
        final result = await _getProviderBookingsUseCase.execute(
          businessId: selectedBusiness.id,
          status: filter.bookingStatus?.name,
        );
        if (requestId != _loadRequestId) return;
        if (result is! Success<BookingListResponse>) throw Exception();
        final page = result.value;
        _nextBookingCursor = page.nextCursor;
        emit(
          ClientBookingsState(
            filter: filter,
            bookings: page.items,
            businesses: businesses,
            selectedBusiness: selectedBusiness,
            tab: ClientBookingsTab.stays,
            isLoading: false,
            hasReachedEnd: page.nextCursor == null,
          ),
        );
        return;
      }
      final result = await _getProviderAppointmentsUseCase.execute(
        businessId: selectedBusiness.id,
        status: filter == ClientBookingFilter.all ? null : filter.name,
      );
      if (requestId != _loadRequestId) {
        return;
      }
      if (result is! Success<AppointmentListResponse>) throw Exception();
      final page = result.value;
      _nextAppointmentCursor = page.nextCursor;
      emit(
        ClientBookingsState(
          filter: filter,
          appointments: page.items,
          businesses: businesses,
          selectedBusiness: selectedBusiness,
          tab: ClientBookingsTab.services,
          isLoading: false,
          hasReachedEnd: page.nextCursor == null,
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

  Future<void> loadMore() async {
    final cursor = state.tab == ClientBookingsTab.stays
        ? _nextBookingCursor
        : _nextAppointmentCursor;
    if (cursor == null || state.isLoadingMore) {
      return;
    }

    emit(
      ClientBookingsState(
        filter: state.filter,
        bookings: state.bookings,
        appointments: state.appointments,
        businesses: state.businesses,
        selectedBusiness: state.selectedBusiness,
        tab: state.tab,
        isLoading: false,
        isLoadingMore: true,
      ),
    );

    try {
      if (state.tab == ClientBookingsTab.stays) {
        final result = await _getProviderBookingsUseCase.execute(
          businessId: state.selectedBusiness!.id,
          status: state.filter.bookingStatus?.name,
          cursor: cursor,
        );
        if (cursor != _nextBookingCursor) return;
        if (result is! Success<BookingListResponse>) throw Exception();
        final page = result.value;
        _nextBookingCursor = page.nextCursor;
        emit(
          ClientBookingsState(
            filter: state.filter,
            bookings: [...state.bookings, ...page.items],
            businesses: state.businesses,
            selectedBusiness: state.selectedBusiness,
            tab: state.tab,
            isLoading: false,
            hasReachedEnd: page.nextCursor == null,
          ),
        );
        return;
      }
      final result = await _getProviderAppointmentsUseCase.execute(
        businessId: state.selectedBusiness!.id,
        status: state.filter == ClientBookingFilter.all
            ? null
            : state.filter.name,
        cursor: cursor,
      );
      if (cursor != _nextAppointmentCursor) return;
      if (result is! Success<AppointmentListResponse>) throw Exception();
      final page = result.value;
      _nextAppointmentCursor = page.nextCursor;
      emit(
        ClientBookingsState(
          filter: state.filter,
          appointments: [...state.appointments, ...page.items],
          businesses: state.businesses,
          selectedBusiness: state.selectedBusiness,
          tab: state.tab,
          isLoading: false,
          hasReachedEnd: page.nextCursor == null,
        ),
      );
    } catch (_) {
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
      final result = await _updateProviderBookingStatusUseCase.execute(
        bookingId: booking.id,
        status: 'declined',
      );
      if (result is! Success<BookingModel>) return false;
      _replaceBooking(result.value);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> completeBooking(BookingModel booking) async {
    try {
      final result = await _updateProviderBookingStatusUseCase.execute(
        bookingId: booking.id,
        status: 'completed',
      );
      if (result is! Success<BookingModel>) return false;
      _replaceBooking(result.value);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> markBookingNoShow(BookingModel booking) async {
    try {
      final result = await _updateProviderBookingStatusUseCase.execute(
        bookingId: booking.id,
        status: 'no_show',
      );
      if (result is! Success<BookingModel>) return false;
      _replaceBooking(result.value);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> declineAppointment(AppointmentModel appointment) async {
    try {
      final result = await _updateProviderAppointmentStatusUseCase.execute(
        appointmentId: appointment.id,
        status: 'declined',
      );
      if (result is! Success<AppointmentModel>) return false;
      _replaceAppointment(result.value);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> completeAppointment(AppointmentModel appointment) async {
    try {
      final result = await _updateProviderAppointmentStatusUseCase.execute(
        appointmentId: appointment.id,
        status: 'completed',
      );
      if (result is! Success<AppointmentModel>) return false;
      _replaceAppointment(result.value);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> markAppointmentNoShow(AppointmentModel appointment) async {
    try {
      final result = await _updateProviderAppointmentStatusUseCase.execute(
        appointmentId: appointment.id,
        status: 'no_show',
      );
      if (result is! Success<AppointmentModel>) return false;
      _replaceAppointment(result.value);
      return true;
    } catch (_) {
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
