import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/global_widgets/custom_textfield.dart';
import 'package:aquabook/src/features/customer-side/payment/domain/models/payment_input_formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aquabook/l10n/l10n.dart';

class PaymentCardForm extends StatelessWidget {
  const PaymentCardForm({
    super.key,
    required this.cardNumber,
    required this.expiry,
    required this.cvv,
    required this.cardholder,
  });
  final TextEditingController cardNumber;
  final TextEditingController expiry;
  final TextEditingController cvv;
  final TextEditingController cardholder;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.credit_card, color: AppColors.primary),
            SizedBox(width: 12),
            Text(
              context.l10n.creditDebitCard,
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(context.l10n.cardNumber),
        const SizedBox(height: 8),
        CustomTextField(
          hintText: context.l10n.cardNumberExample,
          controller: cardNumber,
          keyboardType: TextInputType.number,
          inputFormatters: [CardNumberInputFormatter()],
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.l10n.expiry),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hintText: context.l10n.expiryExample,
                    controller: expiry,
                    keyboardType: TextInputType.number,
                    inputFormatters: [CardExpiryInputFormatter()],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.l10n.cvv),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hintText: context.l10n.cvvExample,
                    controller: cvv,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Text(context.l10n.nameOnCard),
        const SizedBox(height: 8),
        CustomTextField(hintText: context.l10n.cardholderNameExample, controller: cardholder),
      ],
    ),
  );
}
