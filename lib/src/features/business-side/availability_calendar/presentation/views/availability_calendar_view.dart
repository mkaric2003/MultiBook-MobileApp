import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/data/enums/booking_status.dart';
import 'package:multibook/src/data/models/booking_model.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/domain/use_cases/users/user_profile_use_case.dart';
import 'package:multibook/src/features/business-side/availability_calendar/bloc/availability_calendar_cubit.dart';
import 'package:multibook/src/features/business-side/availability_calendar/bloc/availability_calendar_state.dart';
import 'package:multibook/src/features/business-side/availability_calendar/domain/models/availability_day_summary.dart';
import 'package:multibook/src/features/business-side/availability_calendar/presentation/widgets/availability_calendar.dart';
import 'package:multibook/src/features/business-side/availability_calendar/presentation/widgets/availability_calendar_legend.dart';
import 'package:multibook/src/features/business-side/availability_calendar/presentation/widgets/availability_calendar_mode_button.dart';
import 'package:multibook/src/features/business-side/availability_calendar/presentation/widgets/todays_booking_card.dart';
import 'package:multibook/src/features/business-side/availability_calendar/presentation/widgets/todays_bookings_empty_state.dart';
import 'package:multibook/src/features/business-side/availability_calendar/presentation/views/service_availability_calendar_view.dart';
import 'package:multibook/src/global_widgets/custom_app_bar.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AvailabilityCalendarView extends HookWidget {
  const AvailabilityCalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = useMemoized(() => getIt<AvailabilityCalendarCubit>());
    final visibleDate = useState(DateTime.now());
    final selectedDate = useState(DateTime.now());
    final isMonthly = useState(true);
    final selectedBusinessId = useValueListenable(
      getIt<UserProfileUseCase>().selectedBusinessId,
    );

    useEffect(() {
      cubit.load();
      return cubit.close;
    }, [cubit, selectedBusinessId]);

    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<AvailabilityCalendarCubit, AvailabilityCalendarState>(
        builder: (context, state) => Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                CustomAppBar(title: context.l10n.availabilityAndCalendar),
                Expanded(
                  child: state.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : state.business == null
                      ? const Center(
                          child: Text(
                            'Select a business to view availability.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors.muted),
                          ),
                        )
                      : state.business!.type == BusinessType.services
                      ? ServiceAvailabilityCalendarView(
                          key: ValueKey(state.business!.id),
                          business: state.business!,
                        )
                      : SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(25, 28, 25, 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                              AvailabilityCalendar(
                                visibleDate: visibleDate.value,
                                isMonthly: isMonthly.value,
                                selectedDate: selectedDate.value,
                                daySummaries: _daySummaries(
                                  business: state.business!,
                                  bookings: state.bookings,
                                ),
                                onPrevious: () =>
                                    visibleDate.value = isMonthly.value
                                    ? DateTime(
                                        visibleDate.value.year,
                                        visibleDate.value.month - 1,
                                      )
                                    : visibleDate.value.subtract(
                                        const Duration(days: 7),
                                      ),
                                onNext: () =>
                                    visibleDate.value = isMonthly.value
                                    ? DateTime(
                                        visibleDate.value.year,
                                        visibleDate.value.month + 1,
                                      )
                                    : visibleDate.value.add(
                                        const Duration(days: 7),
                                      ),
                                onDateSelected: (date) =>
                                    selectedDate.value = date,
                              ),
                              const SizedBox(height: 24),
                              const AvailabilityCalendarLegend(),
                              const SizedBox(height: 38),
                              Text(
                                context.l10n.todaysBookings,
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 18),
                              if (_todaysBookings(state.bookings).isEmpty)
                                const TodaysBookingsEmptyState()
                              else
                                ..._todaysBookings(state.bookings).map(
                                  (booking) => Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: TodaysBookingCard(booking: booking),
                                  ),
                                ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Map<DateTime, AvailabilityDaySummary> _daySummaries({
    required BusinessModel business,
    required List<BookingModel> bookings,
  }) {
    final totalRooms = business.stayDetails?.rooms.isEmpty ?? true
        ? 1
        : business.stayDetails!.rooms.fold(
            0,
            (total, room) => total + room.quantity,
          );
    final summaries = <DateTime, AvailabilityDaySummary>{};
    for (final booking in bookings) {
      var date = _dateOnly(booking.checkIn);
      final checkOut = _dateOnly(booking.checkOut);
      while (date.isBefore(checkOut)) {
        final existing = summaries[date];
        final statuses = [...?existing?.statuses, booking.status];
        summaries[date] = AvailabilityDaySummary(
          statuses: statuses,
          bookedRooms:
              (existing?.bookedRooms ?? 0) +
              (_occupiesInventory(booking.status) ? 1 : 0),
          totalRooms: totalRooms,
        );
        date = date.add(const Duration(days: 1));
      }
    }
    return summaries;
  }

  List<BookingModel> _todaysBookings(List<BookingModel> bookings) {
    final today = _dateOnly(DateTime.now());
    return bookings
        .where((booking) => _dateOnly(booking.checkIn) == today)
        .toList();
  }

  DateTime _dateOnly(DateTime value) =>
      DateTime(value.year, value.month, value.day);

  bool _occupiesInventory(BookingStatus status) =>
      status == BookingStatus.confirmed || status == BookingStatus.completed;
}
