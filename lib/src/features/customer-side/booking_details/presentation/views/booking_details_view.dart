import 'package:aquabook/app.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/booking_details/bloc/booking_details_cubit.dart';
import 'package:aquabook/src/features/customer-side/booking_details/bloc/booking_details_state.dart';
import 'package:aquabook/src/features/customer-side/booking_details/domain/models/booking_details_arguments.dart';
import 'package:aquabook/src/features/customer-side/booking_details/presentation/widgets/booking_calendar.dart';
import 'package:aquabook/src/features/customer-side/booking_details/presentation/widgets/booking_guest_counter.dart';
import 'package:aquabook/src/features/customer-side/booking_details/presentation/widgets/booking_selected_dates.dart';
import 'package:aquabook/src/features/customer-side/booking_details/presentation/widgets/booking_summary_card.dart';
import 'package:aquabook/src/features/customer-side/review_stay/domain/models/review_stay_arguments.dart';
import 'package:aquabook/src/global_widgets/custom_app_bar.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BookingDetailsView extends StatelessWidget {
  const BookingDetailsView({super.key, required this.arguments});
  final BookingDetailsArguments arguments;
  @override
  Widget build(BuildContext context) {
    final pricePerNight =
        arguments.pricePerNight ?? arguments.stay.pricePerNight ?? 0;
    return BlocProvider(
      create: (_) {
        final cubit = getIt<BookingDetailsCubit>();
        if (arguments.draft != null) cubit.restoreDraft(arguments.draft!);
        return cubit..loadAvailability(arguments.stay.id);
      },
      child: BlocBuilder<BookingDetailsCubit, BookingDetailsState>(
        builder: (context, state) => Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Column(
              children: [
                CustomAppBar(
                  title: 'Booking details',
                  onBackPressed: () async {
                    final shouldSave = await showDialog<bool>(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                        title: const Text('Save booking draft?'),
                        content: const Text(
                          'You can continue this booking later from Home.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.pop(dialogContext, false),
                            child: const Text('Discard'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(dialogContext, true),
                            child: const Text('Save draft'),
                          ),
                        ],
                      ),
                    );
                    if (!context.mounted) return;
                    if (shouldSave == true) {
                      await context.read<BookingDetailsCubit>().saveDraft(
                        arguments,
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
                        const Text(
                          'Select dates',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 18),
                        BookingCalendar(
                          checkIn: state.checkIn,
                          checkOut: state.checkOut,
                          visibleMonth: state.visibleMonth,
                          unavailableDates: state.unavailableDates,
                          isLoadingAvailability: state.isLoadingAvailability,
                          onDateSelected: context
                              .read<BookingDetailsCubit>()
                              .selectDate,
                          onPreviousMonth: context
                              .read<BookingDetailsCubit>()
                              .showPreviousMonth,
                          onNextMonth: context
                              .read<BookingDetailsCubit>()
                              .showNextMonth,
                        ),
                        const SizedBox(height: 16),
                        BookingSelectedDates(
                          checkIn: state.checkIn,
                          checkOut: state.checkOut,
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'Guests',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 16),
                        BookingGuestCounter(
                          label: 'Adults',
                          subtitle: 'Ages 13+',
                          value: state.adults,
                          onChanged: context
                              .read<BookingDetailsCubit>()
                              .changeAdults,
                        ),
                        const SizedBox(height: 12),
                        BookingGuestCounter(
                          label: 'Children',
                          subtitle: 'Ages 2=12',
                          value: state.children,
                          onChanged: context
                              .read<BookingDetailsCubit>()
                              .changeChildren,
                        ),
                        const SizedBox(height: 12),
                        BookingGuestCounter(
                          label: 'Infants',
                          subtitle: 'Under 2',
                          value: state.infants,
                          onChanged: context
                              .read<BookingDetailsCubit>()
                              .changeInfants,
                        ),
                        const SizedBox(height: 32),
                        BookingSummaryCard(
                          state: state,
                          pricePerNight: pricePerNight,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(22, 16, 22, 22),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: AppColors.surfaceHighlight),
                    ),
                  ),
                  child: CustomButton(
                    buttonName: 'Continue',
                    onPressed: () async => context.push(
                      AppRoutes.REVIEW_STAY,
                      extra: ReviewStayArguments(
                        booking: arguments,
                        bookingState: state,
                      ),
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
}
