import 'package:aquabook/src/data/enums/booking_status.dart';
import 'package:aquabook/src/data/models/booking_model.dart';
import 'package:aquabook/src/data/repositories/booking_repository.dart';
import 'package:aquabook/src/features/customer-side/customer_booking_details/cubit/customer_booking_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CustomerBookingDetailsCubit extends Cubit<CustomerBookingDetailsState> {
  CustomerBookingDetailsCubit(
    this._bookingRepository,
    @factoryParam BookingModel booking,
  ) : super(CustomerBookingDetailsState(booking: booking));

  final BookingRepository _bookingRepository;

  Future<void> cancelBooking() async {
    emit(state.copyWith(isCancelling: true));
    try {
      await _bookingRepository.cancelBooking(bookingId: state.booking.id);
      emit(
        state.copyWith(
          booking: state.booking.copyWith(status: BookingStatus.cancelled),
          isCancelling: false,
        ),
      );
    } on BookingException catch (error) {
      emit(state.copyWith(isCancelling: false, errorMessage: error.message));
    }
  }
}
