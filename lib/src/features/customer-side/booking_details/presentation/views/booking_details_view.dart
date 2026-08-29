import 'package:multibook/app.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/customer-side/booking_details/bloc/booking_details_cubit.dart';
import 'package:multibook/src/features/customer-side/booking_details/bloc/booking_details_state.dart';
import 'package:multibook/src/features/customer-side/booking_details/domain/models/booking_details_arguments.dart';
import 'package:multibook/src/features/customer-side/booking_details/presentation/widgets/booking_calendar.dart';
import 'package:multibook/src/features/customer-side/booking_details/presentation/widgets/booking_guest_counter.dart';
import 'package:multibook/src/features/customer-side/booking_details/presentation/widgets/booking_selected_dates.dart';
import 'package:multibook/src/features/customer-side/booking_details/presentation/widgets/booking_summary_card.dart';
import 'package:multibook/src/features/customer-side/review_stay/domain/models/review_stay_arguments.dart';
import 'package:multibook/src/global_widgets/custom_app_bar.dart';
import 'package:multibook/src/global_widgets/custom_button.dart';
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
                  title: context.l10n.bookingDetails,
                  onBackPressed: () async {
                    final shouldSave = await showDialog<bool>(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                        title: Text(context.l10n.saveBookingDraft),
                        content: Text(context.l10n.continueBookingLater),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.pop(dialogContext, false),
                            child: Text(context.l10n.discard),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(dialogContext, true),
                            child: Text(context.l10n.saveDraft),
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
                        Text(
                          context.l10n.selectDates,
                          style: const TextStyle(
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
                        Text(
                          context.l10n.guestSelection,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 16),
                        BookingGuestCounter(
                          label: context.l10n.adult,
                          subtitle: context.l10n.ages13Plus,
                          value: state.adults,
                          onChanged: context
                              .read<BookingDetailsCubit>()
                              .changeAdults,
                        ),
                        const SizedBox(height: 12),
                        BookingGuestCounter(
                          label: context.l10n.child,
                          subtitle: context.l10n.ages2To12,
                          value: state.children,
                          onChanged: context
                              .read<BookingDetailsCubit>()
                              .changeChildren,
                        ),
                        const SizedBox(height: 12),
                        BookingGuestCounter(
                          label: context.l10n.infant,
                          subtitle: context.l10n.under2,
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
                    buttonName: context.l10n.continueLabel,
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
