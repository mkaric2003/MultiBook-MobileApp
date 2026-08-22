import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/booking_confirmed/domain/models/booking_confirmed_arguments.dart';
import 'package:aquabook/src/features/customer-side/booking_confirmed/presentation/widgets/booking_confirmation_card.dart';
import 'package:aquabook/src/features/customer-side/booking_confirmed/presentation/widgets/booking_confirmation_details.dart';
import 'package:aquabook/src/features/customer-side/booking_confirmed/presentation/widgets/booking_confirmation_header.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookingConfirmedView extends StatelessWidget {
  const BookingConfirmedView({super.key, required this.arguments});
  final BookingConfirmedArguments arguments;
  @override
  Widget build(BuildContext context) {
    final booking = arguments.payment.review.bookingState;
    final total = arguments.booking.total;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 28, 22, 5),
          child: Column(
            children: [
              const BookingConfirmationHeader(),
              const SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      BookingConfirmationCard(
                        stay: arguments.payment.review.booking.stay,
                        booking: booking,
                      ),
                      const SizedBox(height: 18),
                      BookingConfirmationDetails(
                        code: arguments.booking.confirmationCode,
                        total: total,
                      ),
                      const SizedBox(height: 18),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: .18),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "What's next?",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 14),
                            Text(
                              '✉  Confirmation email sent\nCheck your inbox for details',
                              style: TextStyle(color: AppColors.muted),
                            ),
                            SizedBox(height: 12),
                            Text(
                              '▣  Added to calendar\nReminder set for check-in day',
                              style: TextStyle(color: AppColors.muted),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),

              CustomButton(
                buttonName: context.l10n.backToHome,
                color: AppColors.surfaceHighlight,
                onPressed: () async => context.go('/customer-home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
