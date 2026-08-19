import 'package:aquabook/src/data/repositories/appointment_repository.dart';
import 'package:aquabook/src/data/repositories/service_availability_repository.dart';
import 'package:aquabook/src/features/customer-side/create_appointment/cubit/appointment_availability_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppointmentAvailabilityCubit extends Cubit<AppointmentAvailabilityState> {
  AppointmentAvailabilityCubit(
    this._repository,
    this._serviceAvailabilityRepository,
  ) : super(const AppointmentAvailabilityState());

  final AppointmentRepository _repository;
  final ServiceAvailabilityRepository _serviceAvailabilityRepository;
  var _requestId = 0;

  Future<void> load({
    required String businessId,
    required String providerId,
    required DateTime date,
  }) async {
    final requestId = ++_requestId;
    emit(const AppointmentAvailabilityState(isLoading: true));
    try {
      final results = await Future.wait([
        _repository.getBookedSlotStarts(
          businessId: businessId,
          providerId: providerId,
          date: date,
        ),
        _serviceAvailabilityRepository.getBlockedSlotStarts(
          businessId: businessId,
          providerId: providerId,
          date: date,
        ),
      ]);
      final bookedStartMinutes = <int>{...results[0], ...results[1]};
      if (isClosed || requestId != _requestId) return;
      emit(
        AppointmentAvailabilityState(bookedStartMinutes: bookedStartMinutes),
      );
    } on AppointmentException catch (error) {
      if (isClosed || requestId != _requestId) return;
      emit(AppointmentAvailabilityState(errorMessage: error.message));
    } on ServiceAvailabilityException catch (error) {
      if (isClosed || requestId != _requestId) return;
      emit(AppointmentAvailabilityState(errorMessage: error.message));
    } catch (_) {
      if (isClosed || requestId != _requestId) return;
      emit(
        const AppointmentAvailabilityState(
          errorMessage: 'We could not load availability. Please try again.',
        ),
      );
    }
  }

  void reset() {
    _requestId++;
    emit(const AppointmentAvailabilityState());
  }
}
