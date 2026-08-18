import 'package:aquabook/src/data/enums/business_type.dart';
import 'package:aquabook/src/data/models/business_model.dart';
import 'package:aquabook/src/data/repositories/booking_repository.dart';
import 'package:aquabook/src/data/repositories/business_repository.dart';
import 'package:aquabook/src/data/repositories/user_repository.dart';
import 'package:aquabook/src/features/business-side/availability_calendar/bloc/availability_calendar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AvailabilityCalendarCubit extends Cubit<AvailabilityCalendarState> {
  AvailabilityCalendarCubit(
    this._bookingRepository,
    this._businessRepository,
    this._userRepository,
  ) : super(const AvailabilityCalendarState());

  final BookingRepository _bookingRepository;
  final BusinessRepository _businessRepository;
  final UserRepository _userRepository;

  Future<void> load() async {
    try {
      final user = await _userRepository.getCurrentUser();
      final businesses = (await _businessRepository.getOwnedBusinesses())
          .where((business) => business.type == BusinessType.stays)
          .toList();
      final business =
          _findBusiness(businesses, user?.selectedBusinessId) ??
          (businesses.isEmpty ? null : businesses.first);

      if (business == null) {
        emit(const AvailabilityCalendarState(isLoading: false));
        return;
      }

      if (business.id != user?.selectedBusinessId) {
        await _userRepository.setSelectedBusiness(businessId: business.id);
      }

      final bookings = await _bookingRepository.getOwnedBusinessBookings(
        businessId: business.id,
      );
      emit(
        AvailabilityCalendarState(
          isLoading: false,
          business: business,
          bookings: bookings,
        ),
      );
    } on BookingException catch (error) {
      emit(
        AvailabilityCalendarState(
          isLoading: false,
          errorMessage: error.message,
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
