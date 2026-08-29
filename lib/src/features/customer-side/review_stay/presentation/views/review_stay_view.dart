import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/app.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/customer-side/review_stay/cubit/review_stay_cubit.dart';
import 'package:multibook/src/features/customer-side/review_stay/cubit/review_stay_state.dart';
import 'package:multibook/src/features/customer-side/review_stay/domain/models/review_stay_arguments.dart';
import 'package:multibook/src/features/customer-side/review_stay/presentation/widgets/review_extra_tile.dart';
import 'package:multibook/src/features/customer-side/review_stay/presentation/widgets/review_price_breakdown.dart';
import 'package:multibook/src/features/customer-side/payment/domain/models/payment_arguments.dart';
import 'package:multibook/src/features/customer-side/payment/cubit/booking_promotion_cubit.dart';
import 'package:multibook/src/features/customer-side/payment/cubit/booking_promotion_state.dart';
import 'package:multibook/src/global_widgets/custom_app_bar.dart';
import 'package:multibook/src/global_widgets/custom_button.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ReviewStayView extends StatelessWidget {
  const ReviewStayView({super.key, required this.arguments});
  final ReviewStayArguments arguments;
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => getIt<ReviewStayCubit>()
          ..loadStay(
            arguments.booking.stay.id,
            selectedExtras: arguments.booking.draft?.selectedExtras ?? const [],
          ),
      ),
      BlocProvider(
        create: (_) =>
            getIt<BookingPromotionCubit>()
              ..load(arguments.booking.stay.id),
      ),
    ],
    child: BlocBuilder<ReviewStayCubit, ReviewStayState>(
      builder: (context, state) {
        if (state.isLoading || state.business == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final business = state.business!;
        final booking = arguments.bookingState;
        final price =
            arguments.booking.pricePerNight ??
            business.stayDetails?.pricePerNight ??
            0;
        final dates =
            '${DateFormat('MMM d').format(booking.checkIn)}–${DateFormat('MMM d, yyyy').format(booking.checkOut)}';
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Column(
              children: [
                CustomAppBar(
                  title: context.l10n.bookingDetails,
                  onBackPressed: () async {
                    final save = await showDialog<bool>(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                        title: Text(context.l10n.saveBookingDraft),
                        content: Text(context.l10n.saveSelectedExtras),
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
                    if (save == true) {
                      await context.read<ReviewStayCubit>().saveDraft(
                        arguments,
                      );
                      if (context.mounted) context.go(AppRoutes.CUSTOMER_HOME);
                      return;
                    }
                    context.pop();
                  },
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(22, 22, 22, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  business.coverPhotoUrl ??
                                      business.logoUrl ??
                                      '',
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) => const SizedBox(
                                    width: 90,
                                    height: 90,
                                    child: ColoredBox(
                                      color: AppColors.surfaceHighlight,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      business.name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      business.location.city,
                                      style: const TextStyle(
                                        color: AppColors.muted,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '📅 $dates',
                                      style: const TextStyle(
                                        color: AppColors.muted,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '👤 ${booking.adults} adults, ${booking.children} children',
                                      style: const TextStyle(
                                        color: AppColors.muted,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 28),
                        Text(
                          context.l10n.addExtras,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 16),
                        for (final extra
                            in business.stayDetails?.extras ?? const []) ...[
                          ReviewExtraTile(
                            extra: extra,
                            selected: state.selectedExtras.contains(extra),
                            onChanged: (_) => context
                                .read<ReviewStayCubit>()
                                .toggleExtra(extra),
                          ),
                          const SizedBox(height: 14),
                        ],
                        const SizedBox(height: 18),
                        BlocBuilder<BookingPromotionCubit, BookingPromotionState>(
                          builder: (context, promotionState) =>
                              ReviewPriceBreakdown(
                                state: booking,
                                pricePerNight: price,
                                extras: state.selectedExtras,
                                promotion: promotionState.promotion,
                              ),
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
                    buttonName: context.l10n.proceedToPayment,
                    onPressed: () async => context.push(
                      AppRoutes.PAYMENT,
                      extra: PaymentArguments(
                        review: arguments,
                        selectedExtras: state.selectedExtras,
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
  );
}
