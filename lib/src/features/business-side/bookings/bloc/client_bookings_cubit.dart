import 'package:aquabook/src/data/data_cursor.dart';
import 'package:aquabook/src/data/enums/booking_status.dart';
import 'package:aquabook/src/data/enums/business_type.dart';
import 'package:aquabook/src/data/models/booking_model.dart';
import 'package:aquabook/src/data/models/business_model.dart';
import 'package:aquabook/src/data/repositories/booking_repository.dart';
import 'package:aquabook/src/data/repositories/business_repository.dart';
import 'package:aquabook/src/data/repositories/user_repository.dart';
import 'package:aquabook/src/features/business-side/bookings/bloc/client_bookings_state.dart';
import 'package:aquabook/src/features/business-side/bookings/domain/enums/client_booking_filter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ClientBookingsCubit extends Cubit<ClientBookingsState> {
  ClientBookingsCubit(
    this._bookingRepository,
    this._businessRepository,
    this._userRepository,
  ) : super(const ClientBookingsState());

  final BookingRepository _bookingRepository;
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
      ),
    );

    try {
      final user = await _userRepository.getCurrentUser();
      final businesses = (await _businessRepository.getOwnedBusinesses())
          .where((business) => business.type == BusinessType.stays)
          .toList();
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

      _cursor = _bookingRepository.getOwnedBookingsCursor(
        businessId: selectedBusiness.id,
        status: filter.bookingStatus,
      );
      final bookings = await _cursor!.fetchNextPage();
      if (requestId != _loadRequestId) {
        return;
      }
      emit(
        ClientBookingsState(
          filter: filter,
          bookings: bookings,
          businesses: businesses,
          selectedBusiness: selectedBusiness,
          isLoading: false,
          hasReachedEnd: _cursor!.isEverythingLoaded,
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
          isLoading: false,
          errorMessage: 'We could not load bookings. Please try again.',
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
      ClientBookingsState(
        filter: state.filter,
        bookings: state.bookings,
        businesses: state.businesses,
        selectedBusiness: state.selectedBusiness,
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

  Future<bool> cancelBooking(BookingModel booking) async {
    try {
      await _bookingRepository.cancelBooking(bookingId: booking.id);
      final cancelledBooking = booking.copyWith(
        status: BookingStatus.cancelled,
      );
      final updatedBookings =
          state.filter == ClientBookingFilter.all ||
              state.filter == ClientBookingFilter.cancelled
          ? state.bookings
                .map(
                  (currentBooking) => currentBooking.id == booking.id
                      ? cancelledBooking
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
          isLoading: false,
          hasReachedEnd: state.hasReachedEnd,
        ),
      );
      return true;
    } on BookingException {
      return false;
    }
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
