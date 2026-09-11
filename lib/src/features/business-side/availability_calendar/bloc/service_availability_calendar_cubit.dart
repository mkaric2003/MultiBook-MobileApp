import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/data/models/appointment_list_response.dart';
import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/data/models/service_availability_block_model.dart';
import 'package:multibook/src/domain/use_cases/provider_bookings/get_provider_appointments_use_case.dart';
import 'package:multibook/src/domain/use_cases/service_availability/create_service_availability_block_use_case.dart';
import 'package:multibook/src/domain/use_cases/service_availability/delete_service_availability_block_use_case.dart';
import 'package:multibook/src/domain/use_cases/service_availability/get_service_availability_blocks_use_case.dart';
import 'package:multibook/src/features/business-side/availability_calendar/bloc/service_availability_calendar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceAvailabilityCalendarCubit
    extends Cubit<ServiceAvailabilityCalendarState> {
  ServiceAvailabilityCalendarCubit(
    this._getProviderAppointmentsUseCase,
    this._getBlocksUseCase,
    this._createBlockUseCase,
    this._deleteBlockUseCase,
  ) : super(const ServiceAvailabilityCalendarState());

  final GetProviderAppointmentsUseCase _getProviderAppointmentsUseCase;
  final GetServiceAvailabilityBlocksUseCase _getBlocksUseCase;
  final CreateServiceAvailabilityBlockUseCase _createBlockUseCase;
  final DeleteServiceAvailabilityBlockUseCase _deleteBlockUseCase;

  Future<void> load({
    required String businessId,
    required List<String> staffIds,
  }) async {
    emit(const ServiceAvailabilityCalendarState());
    try {
      final appointments = await _loadAppointments(businessId);
      final blocks = await _loadBlocks(businessId, staffIds);
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

  Future<List<ServiceAvailabilityBlockModel>> _loadBlocks(
    String businessId,
    List<String> staffIds,
  ) async {
    final results = await Future.wait(
      staffIds.map(
        (staffId) =>
            _getBlocksUseCase.execute(businessId: businessId, staffId: staffId),
      ),
    );
    final blocks = <ServiceAvailabilityBlockModel>[];
    for (final result in results) {
      if (result is! Success<List<ServiceAvailabilityBlockModel>>) {
        throw Exception();
      }
      blocks.addAll(result.value);
    }
    return blocks;
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
    required List<String> staffIds,
  }) async {
    final startAt = DateTime(
      date.year,
      date.month,
      date.day,
    ).add(Duration(minutes: startMinutes));
    final result = await _createBlockUseCase.execute(
      businessId: businessId,
      staffId: providerId,
      startAt: startAt,
      endAt: startAt.add(const Duration(minutes: 30)),
    );
    if (result is Success<ServiceAvailabilityBlockModel>) {
      await load(businessId: businessId, staffIds: staffIds);
    }
  }

  Future<void> unblockSlot({
    required String businessId,
    required String providerId,
    required String blockId,
    required List<String> staffIds,
  }) async {
    final result = await _deleteBlockUseCase.execute(
      businessId: businessId,
      staffId: providerId,
      blockId: blockId,
    );
    if (result is Success<void>) {
      await load(businessId: businessId, staffIds: staffIds);
    }
  }
}
