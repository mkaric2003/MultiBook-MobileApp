import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/appointment_list_response.dart';
import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/data/repositories/service_availability_repository.dart';
import 'package:multibook/src/domain/use_cases/provider_bookings/get_provider_appointments_use_case.dart';
import 'package:multibook/src/features/business-side/availability_calendar/bloc/service_availability_calendar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceAvailabilityCalendarCubit
    extends Cubit<ServiceAvailabilityCalendarState> {
  ServiceAvailabilityCalendarCubit(
    this._getProviderAppointmentsUseCase,
    this._serviceAvailabilityRepository,
  ) : super(const ServiceAvailabilityCalendarState());

  final GetProviderAppointmentsUseCase _getProviderAppointmentsUseCase;
  final ServiceAvailabilityRepository _serviceAvailabilityRepository;

  Future<void> load({required String businessId}) async {
    emit(const ServiceAvailabilityCalendarState());
    try {
      final appointments = await _loadAppointments(businessId);
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

  Future<List<AppointmentModel>> _loadAppointments(String businessId) async {
    final appointments = <AppointmentModel>[];
    String? cursor;
    do {
      final result = await _getProviderAppointmentsUseCase.execute(
        businessId: businessId,
        cursor: cursor,
      );
      if (result is! Success<AppointmentListResponse>) throw Exception();
      appointments.addAll(result.value.items);
      cursor = result.value.nextCursor;
    } while (cursor != null);
    return appointments;
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
