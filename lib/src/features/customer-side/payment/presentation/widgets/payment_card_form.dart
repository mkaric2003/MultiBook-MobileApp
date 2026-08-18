import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/global_widgets/custom_textfield.dart';
import 'package:aquabook/src/features/customer-side/payment/domain/models/payment_input_formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        const Row(
          children: [
            Icon(Icons.credit_card, color: AppColors.primary),
            SizedBox(width: 12),
            Text(
              'Credit/Debit Card',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text('Card Number'),
        const SizedBox(height: 8),
        CustomTextField(
          hintText: '1234 5678 9012 3456',
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
                  const Text('Expiry'),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hintText: 'MM/YY',
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
                  const Text('CVV'),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hintText: '123',
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
        const Text('Name on Card'),
        const SizedBox(height: 8),
        CustomTextField(hintText: 'John Doe', controller: cardholder),
      ],
    ),
  );
}
