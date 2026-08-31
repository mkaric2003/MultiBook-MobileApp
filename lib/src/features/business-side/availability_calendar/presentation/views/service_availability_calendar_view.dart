import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/enums/booking_status.dart';
import 'package:multibook/src/data/models/appointment_model.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/data/repositories/service_availability_repository.dart';
import 'package:multibook/src/domain/use_cases/provider_bookings/get_provider_appointments_use_case.dart';
import 'package:multibook/src/features/business-side/availability_calendar/bloc/service_availability_calendar_cubit.dart';
import 'package:multibook/src/features/business-side/availability_calendar/bloc/service_availability_calendar_state.dart';
import 'package:multibook/src/features/business-side/availability_calendar/domain/models/availability_day_summary.dart';
import 'package:multibook/src/features/business-side/availability_calendar/presentation/widgets/availability_calendar.dart';
import 'package:multibook/src/features/business-side/availability_calendar/presentation/widgets/availability_calendar_legend.dart';
import 'package:multibook/src/features/business-side/availability_calendar/presentation/widgets/availability_calendar_mode_button.dart';
import 'package:multibook/src/features/business-side/availability_calendar/presentation/widgets/service_day_slots.dart';
import 'package:multibook/src/features/business-side/availability_calendar/presentation/widgets/service_provider_selector.dart';
import 'package:multibook/src/features/business-side/availability_calendar/presentation/widgets/todays_appointment_card.dart';
import 'package:multibook/src/features/business-side/availability_calendar/presentation/widgets/todays_bookings_empty_state.dart';

class ServiceAvailabilityCalendarView extends HookWidget {
  const ServiceAvailabilityCalendarView({required this.business, super.key});

  final BusinessModel business;

  @override
  Widget build(BuildContext context) {
    final providers = business.serviceDetails?.availableProviders ?? const [];
    final cubit = useMemoized(
      () => ServiceAvailabilityCalendarCubit(
        getIt<GetProviderAppointmentsUseCase>(),
        getIt<ServiceAvailabilityRepository>(),
      ),
      [business.id],
    );
    final selectedProviderId = useState<String?>(
      providers.isEmpty ? null : providers.first.id,
    );
    final visibleDate = useState(DateTime.now());
    final selectedDate = useState(DateTime.now());
    final isMonthly = useState(true);

    useEffect(() {
      if (!providers.any(
        (provider) => provider.id == selectedProviderId.value,
      )) {
        selectedProviderId.value = providers.isEmpty
            ? null
            : providers.first.id;
      }
      return cubit.close;
    }, [cubit, business.id]);
    useEffect(() {
      cubit.load(businessId: business.id);
      return null;
    }, [cubit, business.id]);

    return BlocProvider.value(
      value: cubit,
      child:
          BlocBuilder<
            ServiceAvailabilityCalendarCubit,
            ServiceAvailabilityCalendarState
          >(
            builder: (context, state) {
              final selectedProvider = providers
                  .where((provider) => provider.id == selectedProviderId.value)
                  .firstOrNull;
              final selectedAppointments = state.appointments
                  .where((item) => item.providerId == selectedProviderId.value)
                  .toList();
              final selectedDayAppointments = selectedAppointments
                  .where((item) => _sameDay(item.date, selectedDate.value))
                  .toList();
              final selectedDayBlocks = state.blocks
                  .where(
                    (block) =>
                        block.providerId == selectedProviderId.value &&
                        block.dateKey == _dateKey(selectedDate.value),
                  )
                  .toList();
              final todaysAppointments =
                  selectedAppointments
                      .where((item) => _sameDay(item.date, DateTime.now()))
                      .toList()
                    ..sort(
                      (first, second) =>
                          first.startMinutes.compareTo(second.startMinutes),
                    );
              return state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state.errorMessage != null
                  ? Center(
                      child: Text(
                        state.errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppColors.muted),
                      ),
                    )
                  : providers.isEmpty
                  ? const Center(
                      child: Text(
                        'Add a service provider to manage appointment availability.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.muted),
                      ),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(25, 28, 25, 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.l10n.serviceProvider,
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 10),
                          ServiceProviderSelector(
                            providers: providers,
                            selectedProviderId: selectedProviderId.value,
                            onChanged: (providerId) =>
                                selectedProviderId.value = providerId,
                          ),
                          const SizedBox(height: 22),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                AvailabilityCalendarModeButton(
                                  label: 'Monthly',
                                  selected: isMonthly.value,
                                  onTap: () => isMonthly.value = true,
                                ),
                                AvailabilityCalendarModeButton(
                                  label: 'Weekly',
                                  selected: !isMonthly.value,
                                  onTap: () => isMonthly.value = false,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 28),
                          Text(
                            context.l10n.selectDayForSlots,
                            style: TextStyle(
                              color: AppColors.muted,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 12),
                          AvailabilityCalendar(
                            visibleDate: visibleDate.value,
                            isMonthly: isMonthly.value,
                            selectedDate: selectedDate.value,
                            daySummaries: _daySummaries(selectedAppointments),
                            onPrevious: () =>
                                visibleDate.value = isMonthly.value
                                ? DateTime(
                                    visibleDate.value.year,
                                    visibleDate.value.month - 1,
                                  )
                                : visibleDate.value.subtract(
                                    const Duration(days: 7),
                                  ),
                            onNext: () => visibleDate.value = isMonthly.value
                                ? DateTime(
                                    visibleDate.value.year,
                                    visibleDate.value.month + 1,
                                  )
                                : visibleDate.value.add(
                                    const Duration(days: 7),
                                  ),
                            onDateSelected: (date) => selectedDate.value = date,
                          ),
                          const SizedBox(height: 24),
                          const AvailabilityCalendarLegend(),
                          const SizedBox(height: 34),
                          if (selectedProvider != null)
                            ServiceDaySlots(
                              provider: selectedProvider,
                              date: selectedDate.value,
                              appointments: selectedDayAppointments,
                              blocks: selectedDayBlocks,
                              onBlockSlot: (startMinutes) => context
                                  .read<ServiceAvailabilityCalendarCubit>()
                                  .blockSlot(
                                    businessId: business.id,
                                    providerId: selectedProvider.id,
                                    date: selectedDate.value,
                                    startMinutes: startMinutes,
                                  ),
                              onUnblockSlot: (block) => context
                                  .read<ServiceAvailabilityCalendarCubit>()
                                  .unblockSlot(
                                    businessId: business.id,
                                    blockId: block.id,
                                  ),
                            ),
                          const SizedBox(height: 38),
                          Text(
                            context.l10n.todaysAppointments,
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 18),
                          if (todaysAppointments.isEmpty)
                            const TodaysBookingsEmptyState()
                          else
                            ...todaysAppointments.map(
                              (appointment) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: TodaysAppointmentCard(
                                  appointment: appointment,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
            },
          ),
    );
  }

  Map<DateTime, AvailabilityDaySummary> _daySummaries(
    List<AppointmentModel> appointments,
  ) {
    final summaries = <DateTime, AvailabilityDaySummary>{};
    for (final appointment in appointments) {
      final date = DateUtils.dateOnly(appointment.date);
      final existing = summaries[date];
      summaries[date] = AvailabilityDaySummary(
        statuses: [...?existing?.statuses, _bookingStatus(appointment.status)],
        bookedRooms: (existing?.bookedRooms ?? 0) + 1,
        totalRooms: 0,
      );
    }
    return summaries;
  }

  BookingStatus _bookingStatus(String status) => switch (status) {
    'completed' => BookingStatus.completed,
    'cancelled' => BookingStatus.cancelled,
    'declined' => BookingStatus.declined,
    'no_show' => BookingStatus.noShow,
    _ => BookingStatus.confirmed,
  };

  bool _sameDay(DateTime first, DateTime second) =>
      first.year == second.year &&
      first.month == second.month &&
      first.day == second.day;

  String _dateKey(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}
