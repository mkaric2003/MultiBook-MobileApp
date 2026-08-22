import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/models/stay_extra_model.dart';
import 'package:aquabook/src/features/customer-side/payment/domain/models/payment_arguments.dart';
import 'package:flutter/material.dart';

class PaymentPriceBreakdown extends StatelessWidget {
  const PaymentPriceBreakdown({
    super.key,
    required this.arguments,
    required this.pricePerNight,
  });
  final PaymentArguments arguments;
  final int pricePerNight;
  @override
  Widget build(BuildContext context) {
    final booking = arguments.review.bookingState;
    final room = booking.nightCount * pricePerNight;
    final extras = _extraTotal(arguments.selectedExtras, booking.nightCount);
    final cleaning = 25;
    final service = ((room + extras) * .05).round();
    final taxes = ((room + extras + cleaning + service) * .08).round();
    final total = room + extras + cleaning + service + taxes;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.priceBreakdown,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 22),
          _row('Room (${booking.nightCount} nights)', '\$$room'),
          if (extras > 0) ...[
            const SizedBox(height: 12),
            _row('Extras', '\$$extras'),
          ],
          const SizedBox(height: 12),
          _row('Cleaning fee', '\$$cleaning'),
          const SizedBox(height: 12),
          _row('Service fee', '\$$service'),
          const SizedBox(height: 12),
          _row('Taxes', '\$$taxes'),
          const Divider(height: 28, color: AppColors.border),
          _row('Total', '\$$total', bold: true),
        ],
      ),
    );
  }

  int total() {
    final b = arguments.review.bookingState;
    final room = b.nightCount * pricePerNight;
    final extras = _extraTotal(arguments.selectedExtras, b.nightCount);
    final cleaning = 25;
    final service = ((room + extras) * .05).round();
    return room +
        extras +
        cleaning +
        service +
        ((room + extras + cleaning + service) * .08).round();
  }

  int _extraTotal(List<StayExtraModel> extras, int nights) => extras.fold(
    0,
    (sum, extra) => sum + extra.price * (extra.isPerNight ? nights : 1),
  );
  Widget _row(String label, String value, {bool bold = false}) => Row(
    children: [
      Expanded(
        child: Text(
          label,
          style: TextStyle(
            color: bold ? Colors.white : AppColors.muted,
            fontSize: 16,
            fontWeight: bold ? FontWeight.w800 : FontWeight.w500,
          ),
        ),
      ),
      Text(
        value,
        style: TextStyle(
          fontSize: 16,
          fontWeight: bold ? FontWeight.w800 : FontWeight.w700,
        ),
      ),
    ],
  );
}
