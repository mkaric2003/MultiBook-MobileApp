import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/data/models/booking_list_response.dart';
import 'package:multibook/src/data/models/booking_model.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/domain/use_cases/businesses/get_owned_business_use_case.dart';
import 'package:multibook/src/domain/use_cases/businesses/get_owned_businesses_use_case.dart';
import 'package:multibook/src/domain/use_cases/provider_bookings/get_provider_bookings_use_case.dart';
import 'package:multibook/src/domain/use_cases/users/user_profile_use_case.dart';
import 'package:multibook/src/features/business-side/availability_calendar/bloc/availability_calendar_state.dart';

@injectable
class AvailabilityCalendarCubit extends Cubit<AvailabilityCalendarState> {
  AvailabilityCalendarCubit(
    this._getProviderBookingsUseCase,
    this._getOwnedBusinessesUseCase,
    this._getOwnedBusinessUseCase,
    this._userRepository,
  ) : super(const AvailabilityCalendarState());

  final GetProviderBookingsUseCase _getProviderBookingsUseCase;
  final GetOwnedBusinessesUseCase _getOwnedBusinessesUseCase;
  final GetOwnedBusinessUseCase _getOwnedBusinessUseCase;
  final UserProfileUseCase _userRepository;

  Future<void> load() async {
    try {
      final user = await _userRepository.getCurrentUser();
      final businessesResult = await _getOwnedBusinessesUseCase.execute();
      if (businessesResult is! Success<List<BusinessModel>>) throw Exception();
      final businesses = businessesResult.value;
      final businessSummary =
          _findBusiness(businesses, user?.selectedBusinessId) ??
          (businesses.isEmpty ? null : businesses.first);

      if (businessSummary == null) {
        emit(const AvailabilityCalendarState(isLoading: false));
        return;
      }

      if (businessSummary.id != user?.selectedBusinessId) {
        await _userRepository.setSelectedBusiness(
          businessId: businessSummary.id,
        );
      }

      final businessResult = await _getOwnedBusinessUseCase.execute(
        businessSummary.id,
      );
      if (businessResult is! Success<BusinessModel>) throw Exception();
      final business = businessResult.value;

      if (business.type != BusinessType.stays) {
        emit(AvailabilityCalendarState(isLoading: false, business: business));
        return;
      }

      final bookings = await _loadBookings(business.id);
      emit(
        AvailabilityCalendarState(
          isLoading: false,
          business: business,
          bookings: bookings,
        ),
      );
    } catch (_) {
      emit(
        const AvailabilityCalendarState(
          isLoading: false,
          errorMessage: 'We could not load your calendar. Please try again.',
        ),
      );
    }
  }

  Future<List<BookingModel>> _loadBookings(String businessId) async {
    final bookings = <BookingModel>[];
    String? cursor;
    do {
      final result = await _getProviderBookingsUseCase.execute(
        businessId: businessId,
        cursor: cursor,
      );
      if (result is! Success<BookingListResponse>) throw Exception();
      bookings.addAll(result.value.items);
      cursor = result.value.nextCursor;
    } while (cursor != null);
    return bookings;
  }

  BusinessModel? _findBusiness(
    List<BusinessModel> businesses,
    String? businessId,
  ) {
    for (final business in businesses) {
      if (business.id == businessId) return business;
    }
    return null;
  }
}
