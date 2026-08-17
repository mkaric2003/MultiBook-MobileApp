import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/enums/booking_status.dart';
import 'package:aquabook/src/data/models/booking_model.dart';
import 'package:aquabook/src/features/business-side/availability_calendar/bloc/availability_calendar_cubit.dart';
import 'package:aquabook/src/features/business-side/availability_calendar/bloc/availability_calendar_state.dart';
import 'package:aquabook/src/features/business-side/availability_calendar/presentation/widgets/availability_calendar.dart';
import 'package:aquabook/src/features/business-side/availability_calendar/presentation/widgets/availability_calendar_legend.dart';
import 'package:aquabook/src/features/business-side/availability_calendar/presentation/widgets/availability_calendar_mode_button.dart';
import 'package:aquabook/src/features/business-side/availability_calendar/presentation/widgets/todays_booking_card.dart';
import 'package:aquabook/src/features/business-side/availability_calendar/presentation/widgets/todays_bookings_empty_state.dart';
import 'package:aquabook/src/global_widgets/custom_app_bar.dart';
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

    useEffect(() {
      cubit.load();
      return cubit.close;
    }, [cubit]);

    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<AvailabilityCalendarCubit, AvailabilityCalendarState>(
        builder: (context, state) => Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const CustomAppBar(title: 'Availability & Calendar'),
                Expanded(
                  child: state.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : state.business == null
                      ? const Center(
                          child: Text(
                            'Select a stay business to view availability.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors.muted),
                          ),
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
                                statuses: _bookingStatuses(state.bookings),
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
                              const Text(
                                "Today's Bookings",
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

  Map<DateTime, BookingStatus> _bookingStatuses(List<BookingModel> bookings) {
    final statuses = <DateTime, BookingStatus>{};
    for (final booking in bookings) {
      var date = _dateOnly(booking.checkIn);
      final checkOut = _dateOnly(booking.checkOut);
      while (date.isBefore(checkOut)) {
        statuses[date] = _preferredStatus(statuses[date], booking.status);
        date = date.add(const Duration(days: 1));
      }
    }
    return statuses;
  }

  List<BookingModel> _todaysBookings(List<BookingModel> bookings) {
    final today = _dateOnly(DateTime.now());
    return bookings
        .where((booking) => _dateOnly(booking.checkIn) == today)
        .toList();
  }

  DateTime _dateOnly(DateTime value) =>
      DateTime(value.year, value.month, value.day);

  BookingStatus _preferredStatus(
    BookingStatus? currentStatus,
    BookingStatus candidateStatus,
  ) {
    if (currentStatus == null) return candidateStatus;
    const priorities = {
      BookingStatus.confirmed: 4,
      BookingStatus.completed: 3,
      BookingStatus.declined: 2,
      BookingStatus.cancelled: 1,
    };
    return priorities[candidateStatus]! >= priorities[currentStatus]!
        ? candidateStatus
        : currentStatus;
  }
}
