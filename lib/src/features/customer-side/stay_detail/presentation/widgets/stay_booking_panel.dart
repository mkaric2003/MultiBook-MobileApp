import 'package:aquabook/app.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/booking_details/domain/models/booking_details_arguments.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:aquabook/src/features/customer-side/stay_detail/presentation/widgets/stay_booking_field.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StayBookingPanel extends StatelessWidget {
  const StayBookingPanel({super.key, required this.stay});

  final StayListing stay;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Row(
            children: [
              Expanded(
                child: StayBookingField(label: 'Check-in', value: 'Mar 15'),
              ),
              SizedBox(width: 12),
              Expanded(
                child: StayBookingField(label: 'Check-out', value: 'Mar 17'),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const StayBookingField(label: 'Guests', value: '2 adults · 1 child'),
          const SizedBox(height: 18),
          CustomButton(
            buttonName: 'Check availability',
            onPressed: () async => context.push(
              AppRoutes.BOOKING_DETAILS,
              extra: BookingDetailsArguments(stay: stay),
            ),
          ),
        ],
      ),
    );
  }
}
