import 'package:multibook/app.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/data/enums/service_weekday.dart';
import 'package:multibook/src/data/models/service_offering_model.dart';
import 'package:multibook/src/data/models/service_provider_model.dart';
import 'package:multibook/src/features/customer-side/create_appointment/domain/models/appointment_time_availability.dart';
import 'package:multibook/src/features/customer-side/create_appointment/domain/models/create_appointment_arguments.dart';
import 'package:multibook/src/features/customer-side/create_appointment/cubit/appointment_draft_cubit.dart';
import 'package:multibook/src/features/customer-side/create_appointment/cubit/appointment_availability_cubit.dart';
import 'package:multibook/src/features/customer-side/create_appointment/cubit/appointment_availability_state.dart';
import 'package:multibook/src/features/customer-side/create_appointment/presentation/widgets/appointment_calendar.dart';
import 'package:multibook/src/features/customer-side/create_appointment/presentation/widgets/appointment_service_option_card.dart';
import 'package:multibook/src/features/customer-side/create_appointment/presentation/widgets/appointment_provider_option_card.dart';
import 'package:multibook/src/features/customer-side/create_appointment/presentation/widgets/appointment_time_grid.dart';
import 'package:multibook/src/features/customer-side/review_appointment/domain/models/review_appointment_arguments.dart';
import 'package:multibook/src/global_widgets/custom_app_bar.dart';
import 'package:multibook/src/global_widgets/custom_button.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateAppointmentView extends HookWidget {
  const CreateAppointmentView({required this.arguments, super.key});

  final CreateAppointmentArguments arguments;

  @override
  Widget build(BuildContext context) {
    final offerings =
        arguments.business.serviceDetails?.offerings ??
        const <ServiceOfferingModel>[];
    final providers =
        arguments.business.serviceDetails?.availableProviders ??
        const <ServiceProviderModel>[];
    final initialOfferingId =
        offerings.any((offering) => offering.id == arguments.initialOfferingId)
        ? arguments.initialOfferingId
        : offerings.firstOrNull?.id;
    final restoredOfferingIds =
        arguments.draft?.selectedOfferingIds ?? const [];
    final selectedOfferingIds = useState<Set<String>>(
      restoredOfferingIds.isNotEmpty
          ? restoredOfferingIds.toSet()
          : initialOfferingId == null
          ? <String>{}
          : {initialOfferingId},
    );
    final initialProviderId =
        providers.any(
          (provider) => provider.id == arguments.draft?.selectedProviderId,
        )
        ? arguments.draft?.selectedProviderId
        : null;
    final selectedProviderId = useState<String?>(initialProviderId);
    final selectedProvider = providers
        .where((provider) => provider.id == selectedProviderId.value)
        .firstOrNull;
    final selectedDate = useState(
      DateUtils.dateOnly(arguments.draft?.date ?? DateTime.now()),
    );
    final visibleMonth = useState(
      DateTime(selectedDate.value.year, selectedDate.value.month),
    );
    final selectedTime = useState<int?>(arguments.draft?.startMinutes);
    final selectedOfferings = offerings
        .where((offering) => selectedOfferingIds.value.contains(offering.id))
        .toList();
    final totalDurationMinutes = selectedOfferings.fold(
      0,
      (total, offering) => total + offering.durationMinutes,
    );
    final availabilityCubit = useMemoized(
      () => getIt<AppointmentAvailabilityCubit>(),
    );
    useEffect(() => availabilityCubit.close, [availabilityCubit]);
    useEffect(() {
      if (selectedProvider == null) {
        availabilityCubit.reset();
      } else {
        availabilityCubit.load(
          businessId: arguments.business.id,
          providerId: selectedProvider.id,
          date: selectedDate.value,
        );
      }
      return null;
    }, [selectedProvider?.id, selectedDate.value]);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AppointmentDraftCubit>()),
        BlocProvider.value(value: availabilityCubit),
      ],
      child: Builder(
        builder: (context) =>
            BlocBuilder<
              AppointmentAvailabilityCubit,
              AppointmentAvailabilityState
            >(
              builder: (context, availabilityState) {
                final availability = _availableTimes(
                  selectedDate: selectedDate.value,
                  totalDurationMinutes: totalDurationMinutes,
                  provider: selectedProvider,
                  bookedStartMinutes: availabilityState.bookedStartMinutes,
                );
                final canContinue =
                    selectedOfferings.isNotEmpty &&
                    selectedProvider != null &&
                    selectedTime.value != null &&
                    availability.bookableStartTimes.contains(
                      selectedTime.value,
                    );
                return Scaffold(
                  backgroundColor: AppColors.background,
                  body: SafeArea(
                    child: Column(
                      children: [
                        CustomAppBar(
                          title: context.l10n.createAppointment,
                          onBackPressed: () async {
                            final shouldSave = await showDialog<bool>(
                              context: context,
                              builder: (dialogContext) => AlertDialog(
                                title: Text(context.l10n.saveAppointmentDraft),
                                content: Text(
                                  context.l10n.continueAppointmentLater,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(dialogContext, false),
                                    child: Text(context.l10n.discard),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(dialogContext, true),
                                    child: Text(context.l10n.saveDraft),
                                  ),
                                ],
                              ),
                            );
                            if (!context.mounted) return;
                            if (shouldSave == true) {
                              await context.read<AppointmentDraftCubit>().save(
                                business: arguments.business,
                                offeringIds: selectedOfferingIds.value.toList(),
                                providerId: selectedProviderId.value,
                                providerName: selectedProvider?.name,
                                date: selectedDate.value,
                                startMinutes: selectedTime.value,
                              );
                              if (context.mounted) {
                                context.go(AppRoutes.CUSTOMER_HOME);
                              }
                              return;
                            }
                            if (context.mounted) {
                              context.pop();
                            }
                          },
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.fromLTRB(22, 24, 22, 28),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.l10n.selectService,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ...offerings.map(
                                  (offering) => Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: AppointmentServiceOptionCard(
                                      offering: offering,
                                      isSelected: selectedOfferingIds.value
                                          .contains(offering.id),
                                      onTap: () {
                                        final updated = {
                                          ...selectedOfferingIds.value,
                                        };
                                        updated.contains(offering.id)
                                            ? updated.remove(offering.id)
                                            : updated.add(offering.id);
                                        selectedOfferingIds.value = updated;
                                        selectedTime.value = null;
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 26),
                                Text(
                                  context.l10n.selectProvider,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                if (providers.isEmpty)
                                  Text(
                                    context.l10n.noServiceProvidersAvailable,
                                    style: const TextStyle(
                                      color: AppColors.muted,
                                    ),
                                  )
                                else
                                  ...providers.map(
                                    (provider) => Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 12,
                                      ),
                                      child: AppointmentProviderOptionCard(
                                        provider: provider,
                                        isSelected:
                                            selectedProviderId.value ==
                                            provider.id,
                                        onTap: () {
                                          selectedProviderId.value =
                                              provider.id;
                                          selectedTime.value = null;
                                        },
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 26),
                                Text(
                                  context.l10n.selectDate,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                AppointmentCalendar(
                                  visibleMonth: visibleMonth.value,
                                  selectedDate: selectedDate.value,
                                  onPreviousMonth: () {
                                    final current = visibleMonth.value;
                                    final previous = DateTime(
                                      current.year,
                                      current.month - 1,
                                    );
                                    if (!previous.isBefore(
                                      DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                      ),
                                    )) {
                                      visibleMonth.value = previous;
                                    }
                                  },
                                  onNextMonth: () {
                                    final current = visibleMonth.value;
                                    visibleMonth.value = DateTime(
                                      current.year,
                                      current.month + 1,
                                    );
                                  },
                                  onDateSelected: (date) {
                                    selectedDate.value = date;
                                    selectedTime.value = null;
                                  },
                                ),
                                const SizedBox(height: 26),
                                Text(
                                  context.l10n.availableTimes,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                if (availabilityState.isLoading)
                                  const Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      child: CircularProgressIndicator(),
                                    ),
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
                                    selectedDurationMinutes:
                                        totalDurationMinutes,
                                    onTimeSelected: (time) =>
                                        selectedTime.value = time,
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(22, 16, 22, 22),
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: AppColors.surfaceHighlight,
                              ),
                            ),
                          ),
                          child: CustomButton(
                            buttonName: context.l10n.continueLabel,
                            enabled: canContinue,
                            onPressed: !canContinue
                                ? null
                                : () => context.push(
                                    AppRoutes.REVIEW_APPOINTMENT,
                                    extra: ReviewAppointmentArguments(
                                      business: arguments.business,
                                      offerings: selectedOfferings,
                                      provider: selectedProvider,
                                      date: selectedDate.value,
                                      startMinutes: selectedTime.value!,
                                      preselectedAddOnIds:
                                          arguments.draft?.selectedAddOnIds ??
                                          const [],
                                    ),
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
    required DateTime selectedDate,
    required int totalDurationMinutes,
    required ServiceProviderModel? provider,
    required Set<int> bookedStartMinutes,
  }) {
    if (totalDurationMinutes <= 0) {
      return const AppointmentTimeAvailability(
        availableTimes: [],
        bookableStartTimes: {},
      );
    }
    final weekday = ServiceWeekday.values[selectedDate.weekday - 1];
    final slots =
        provider?.availabilitySlots
            .where((slot) => slot.weekday == weekday)
            .toList() ??
        const [];
    final times = <int>{};
    final bookableStartTimes = <int>{};
    for (final slot in slots) {
      for (var time = slot.startMinutes; time < slot.endMinutes; time += 30) {
        times.add(time);
        if (time + totalDurationMinutes <= slot.endMinutes &&
            _isTimeRangeFree(
              start: time,
              durationMinutes: totalDurationMinutes,
              bookedStartMinutes: bookedStartMinutes,
            )) {
          bookableStartTimes.add(time);
        }
      }
    }
    return AppointmentTimeAvailability(
      availableTimes: times.toList()..sort(),
      bookableStartTimes: bookableStartTimes,
    );
  }

  bool _isTimeRangeFree({
    required int start,
    required int durationMinutes,
    required Set<int> bookedStartMinutes,
  }) {
    for (var time = start; time < start + durationMinutes; time += 30) {
      if (bookedStartMinutes.contains(time)) return false;
    }
    return true;
  }
}
