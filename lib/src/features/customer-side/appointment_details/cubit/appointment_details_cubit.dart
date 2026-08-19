import 'package:aquabook/src/data/repositories/business_repository.dart';
import 'package:aquabook/src/data/repositories/appointment_repository.dart';
import 'package:aquabook/src/data/models/appointment_model.dart';
import 'package:aquabook/src/features/customer-side/appointment_details/cubit/appointment_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppointmentDetailsCubit extends Cubit<AppointmentDetailsState> {
  AppointmentDetailsCubit(this._businessRepository, this._appointmentRepository)
    : super(const AppointmentDetailsState());

  final BusinessRepository _businessRepository;
  final AppointmentRepository _appointmentRepository;

  Future<void> load(String businessId) async {
    try {
      final business = await _businessRepository.getBusiness(
        businessId: businessId,
      );
      emit(AppointmentDetailsState(business: business));
    } catch (_) {
      emit(
        const AppointmentDetailsState(
          isLoading: false,
          errorMessage: 'We could not load current business details.',
        ),
      );
    }
  }

  Future<void> cancel(AppointmentModel appointment) async {
    if (state.isCancelling) return;
    emit(
      AppointmentDetailsState(
        isLoading: false,
        isCancelling: true,
        business: state.business,
      ),
    );
    try {
      final updated = await _appointmentRepository.cancelAppointment(
        appointment,
      );
      emit(
        AppointmentDetailsState(
          isLoading: false,
          business: state.business,
          appointment: updated,
        ),
      );
    } on AppointmentException catch (error) {
      emit(
        AppointmentDetailsState(
          isLoading: false,
          business: state.business,
          errorMessage: error.message,
        ),
      );
    }
  }
}
