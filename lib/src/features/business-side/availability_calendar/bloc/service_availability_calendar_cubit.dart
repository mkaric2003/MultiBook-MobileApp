import 'package:aquabook/src/data/repositories/appointment_repository.dart';
import 'package:aquabook/src/data/models/appointment_model.dart';
import 'package:aquabook/src/data/repositories/service_availability_repository.dart';
import 'package:aquabook/src/features/business-side/availability_calendar/bloc/service_availability_calendar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceAvailabilityCalendarCubit
    extends Cubit<ServiceAvailabilityCalendarState> {
  ServiceAvailabilityCalendarCubit(
    this._appointmentRepository,
    this._serviceAvailabilityRepository,
  ) : super(const ServiceAvailabilityCalendarState());

  final AppointmentRepository _appointmentRepository;
  final ServiceAvailabilityRepository _serviceAvailabilityRepository;

  Future<void> load({required String businessId}) async {
    emit(const ServiceAvailabilityCalendarState());
    try {
      final cursor = _appointmentRepository.getOwnedAppointmentsCursor(
        businessId: businessId,
        pageSize: 50,
      );
      final appointments = <AppointmentModel>[];
      while (!cursor.isEverythingLoaded) {
        appointments.addAll(await cursor.fetchNextPage());
      }
      final blocks = await _serviceAvailabilityRepository.getBlocks(
        businessId: businessId,
      );
      emit(
        ServiceAvailabilityCalendarState(
          isLoading: false,
          appointments: appointments,
          blocks: blocks,
        ),
      );
    } on AppointmentException catch (error) {
      emit(
        ServiceAvailabilityCalendarState(
          isLoading: false,
          errorMessage: error.message,
        ),
      );
    } catch (_) {
      emit(
        const ServiceAvailabilityCalendarState(
          isLoading: false,
          errorMessage:
              'We could not load your appointments. Please try again.',
        ),
      );
    }
  }

  Future<void> blockSlot({
    required String businessId,
    required String providerId,
    required DateTime date,
    required int startMinutes,
  }) async {
    await _serviceAvailabilityRepository.blockSlot(
      businessId: businessId,
      providerId: providerId,
      date: date,
      startMinutes: startMinutes,
    );
    await load(businessId: businessId);
  }

  Future<void> unblockSlot({
    required String businessId,
    required String blockId,
  }) async {
    await _serviceAvailabilityRepository.unblockSlot(blockId: blockId);
    await load(businessId: businessId);
  }
}
