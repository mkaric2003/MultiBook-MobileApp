import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/enums/service_weekday.dart';
import 'package:multibook/src/data/models/service_provider_model.dart';
import 'package:multibook/src/features/customer-side/create_appointment/cubit/appointment_availability_cubit.dart';
import 'package:multibook/src/features/customer-side/create_appointment/cubit/appointment_availability_state.dart';
import 'package:multibook/src/features/customer-side/create_appointment/domain/models/appointment_time_availability.dart';
import 'package:multibook/src/features/customer-side/create_appointment/presentation/widgets/appointment_calendar.dart';
import 'package:multibook/src/features/customer-side/create_appointment/presentation/widgets/appointment_time_grid.dart';
import 'package:multibook/src/features/customer-side/reschedule_appointment/cubit/reschedule_appointment_cubit.dart';
import 'package:multibook/src/features/customer-side/reschedule_appointment/cubit/reschedule_appointment_state.dart';
import 'package:multibook/src/features/customer-side/reschedule_appointment/domain/models/reschedule_appointment_arguments.dart';
import 'package:multibook/src/global_widgets/custom_app_bar.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class RescheduleAppointmentView extends HookWidget {
  const RescheduleAppointmentView({required this.arguments, super.key});

  final RescheduleAppointmentArguments arguments;

  @override
  Widget build(BuildContext context) {
    final provider = arguments.business.serviceDetails?.availableProviders
        .where((item) => item.id == arguments.appointment.providerId)
        .firstOrNull;
    final today = DateUtils.dateOnly(DateTime.now());
    final appointmentDate = DateUtils.dateOnly(arguments.appointment.date);
    final selectedDate = useState(appointmentDate);
    final visibleMonth = useState(
      DateTime(appointmentDate.year, appointmentDate.month),
    );
    final selectedTime = useState<int?>(arguments.appointment.startMinutes);
    final durationMinutes =
        arguments.appointment.endMinutes - arguments.appointment.startMinutes;
    final availabilityCubit = useMemoized(
      () => getIt<AppointmentAvailabilityCubit>(),
    );
    useEffect(() => availabilityCubit.close, [availabilityCubit]);
    useEffect(() {
      if (provider == null) {
        availabilityCubit.reset();
      } else {
        availabilityCubit.load(
          businessId: arguments.appointment.businessId,
          providerId: provider.id,
          date: selectedDate.value,
          offeringIds: arguments.appointment.serviceIds,
          excludeAppointmentId: arguments.appointment.id,
        );
      }
      return null;
    }, [provider?.id, selectedDate.value]);

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: availabilityCubit),
        BlocProvider(create: (_) => getIt<RescheduleAppointmentCubit>()),
      ],
      child: BlocConsumer<RescheduleAppointmentCubit, RescheduleAppointmentState>(
        listener: (context, state) {
          if (state.appointment != null) context.pop(state.appointment);
          if (state.errorMessage != null) {
            toastification.show(
              context: context,
              alignment: Alignment.bottomCenter,
              autoCloseDuration: const Duration(seconds: 3),
              type: ToastificationType.error,
              title: Text(state.errorMessage!),
            );
          }
        },
        builder: (context, rescheduleState) =>
            BlocBuilder<
              AppointmentAvailabilityCubit,
              AppointmentAvailabilityState
            >(
              builder: (context, availabilityState) {
                final availability = _availableTimes(
                  date: selectedDate.value,
                  provider: provider,
                  durationMinutes: durationMinutes,
                  availableStartMinutes:
                      availabilityState.availableStartMinutes,
                );
                final canSubmit =
                    provider != null &&
                    selectedTime.value != null &&
                    availability.bookableStartTimes.contains(
                      selectedTime.value,
                    ) &&
                    !rescheduleState.isSubmitting;
                return Scaffold(
                  body: SafeArea(
                    child: Column(
                      children: [
                        CustomAppBar(title: context.l10n.rescheduleAppointment),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.fromLTRB(22, 24, 22, 28),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  arguments.appointment.businessName,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${arguments.appointment.providerName} · $durationMinutes min',
                                  style: TextStyle(
                                    color: context.appPalette.muted,
                                  ),
                                ),
                                const SizedBox(height: 26),
                                Text(
                                  context.l10n.selectNewDate,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                AppointmentCalendar(
                                  visibleMonth: visibleMonth.value,
                                  selectedDate: selectedDate.value,
                                  onPreviousMonth: () {
                                    final previous = DateTime(
                                      visibleMonth.value.year,
                                      visibleMonth.value.month - 1,
                                    );
                                    if (!previous.isBefore(
                                      DateTime(today.year, today.month),
                                    )) {
                                      visibleMonth.value = previous;
                                    }
                                  },
                                  onNextMonth: () =>
                                      visibleMonth.value = DateTime(
                                        visibleMonth.value.year,
                                        visibleMonth.value.month + 1,
                                      ),
                                  onDateSelected: (date) {
                                    selectedDate.value = date;
                                    selectedTime.value = null;
                                  },
                                ),
                                const SizedBox(height: 26),
                                Text(
                                  context.l10n.availableTimes,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                if (provider == null)
                                  Text(
                                    context.l10n.providerNoLongerAvailable,
                                    style: TextStyle(
                                      color: context.appPalette.muted,
                                    ),
                                  )
                                else if (availabilityState.isLoading)
                                  const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                else if (availabilityState.errorMessage != null)
                                  Text(
                                    availabilityState.errorMessage!,
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                    ),
                                  )
                                else
                                  AppointmentTimeGrid(
                                    times: availability.availableTimes,
                                    bookableStartTimes:
                                        availability.bookableStartTimes,
                                    selectedTime: selectedTime.value,
                                    selectedDurationMinutes: durationMinutes,
                                    onTimeSelected: (time) =>
                                        selectedTime.value = time,
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(22, 16, 22, 22),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: context.appPalette.surfaceHighlight,
                              ),
                            ),
                          ),
                          child: CustomButton(
                            buttonName: rescheduleState.isSubmitting
                                ? context.l10n.rescheduling
                                : context.l10n.confirmReschedule,
                            enabled: canSubmit,
                            onPressed: !canSubmit
                                ? null
                                : () => context
                                      .read<RescheduleAppointmentCubit>()
                                      .submit(
                                        appointment: arguments.appointment,
                                        date: selectedDate.value,
                                        startMinutes: selectedTime.value!,
                                      ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      ),
    );
  }

  AppointmentTimeAvailability _availableTimes({
    required DateTime date,
    required ServiceProviderModel? provider,
    required int durationMinutes,
    required Set<int> availableStartMinutes,
  }) {
    if (provider == null || durationMinutes <= 0) {
      return const AppointmentTimeAvailability(
        availableTimes: [],
        bookableStartTimes: {},
      );
    }
    final weekday = ServiceWeekday.values[date.weekday - 1];
    final times = <int>{};
    final starts = <int>{};
    for (final slot in provider.availabilitySlots.where(
      (slot) => slot.weekday == weekday,
    )) {
      for (var time = slot.startMinutes; time < slot.endMinutes; time += 30) {
        times.add(time);
        final canFit = time + durationMinutes <= slot.endMinutes;
        if (canFit && availableStartMinutes.contains(time)) starts.add(time);
      }
    }
    return AppointmentTimeAvailability(
      availableTimes: times.toList()..sort(),
      bookableStartTimes: starts,
    );
  }
}
