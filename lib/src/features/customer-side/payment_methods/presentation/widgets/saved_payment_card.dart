import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/customer-side/payment_methods/cubit/payment_methods_cubit.dart';
import 'package:multibook/src/features/customer-side/payment_methods/domain/enums/saved_card_brand.dart';
import 'package:multibook/src/features/customer-side/payment_methods/domain/models/saved_payment_method_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_credit_card/u_credit_card.dart';

class SavedPaymentCard extends StatelessWidget {
  const SavedPaymentCard({required this.method, super.key});
  final SavedPaymentMethodModel method;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CreditCardUi(
        cardHolderFullName: method.holderName,
        cardNumber: method.maskedNumber,
        validThru: method.expiry,
        showValidFrom: false,
        doesSupportNfc: false,
        topLeftColor: AppColors.primary,
        bottomRightColor: const Color(0xFF3B167B),
        creditCardType: switch (method.brand) {
          SavedCardBrand.visa => CreditCardType.visa,
          SavedCardBrand.mastercard => CreditCardType.mastercard,
          SavedCardBrand.amex => CreditCardType.amex,
          SavedCardBrand.other => CreditCardType.none,
        },
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          if (method.isDefault)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: .18),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                context.l10n.defaultPaymentMethod,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          const Spacer(),
          TextButton(
            onPressed: method.isDefault
                ? null
                : () => context.read<PaymentMethodsCubit>().setDefault(method),
            child: Text(context.l10n.setAsDefault),
          ),
          IconButton(
            onPressed: () =>
                context.read<PaymentMethodsCubit>().delete(method.id),
            icon: const Icon(Icons.delete_outline, color: Color(0xFFF87171)),
          ),
        ],
      ),
    ],
  );
}
