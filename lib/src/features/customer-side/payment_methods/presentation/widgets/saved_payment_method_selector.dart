import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/customer-side/payment_methods/domain/models/saved_payment_method_model.dart';
import 'package:flutter/material.dart';

class SavedPaymentMethodSelector extends StatelessWidget {
  const SavedPaymentMethodSelector({
    required this.methods,
    required this.selectedMethod,
    required this.onSelected,
    super.key,
  });

  final List<SavedPaymentMethodModel> methods;
  final SavedPaymentMethodModel? selectedMethod;
  final ValueChanged<SavedPaymentMethodModel> onSelected;

  @override
  Widget build(BuildContext context) {
    if (methods.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.savedPaymentMethods,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        ...methods.map(
          (method) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: InkWell(
              onTap: () => onSelected(method),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: context.appPalette.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: selectedMethod?.id == method.id
                        ? AppColors.primary
                        : context.appPalette.surfaceHighlight,
                    width: selectedMethod?.id == method.id ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.credit_card, color: AppColors.primary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '${method.maskedNumber}  •  ${method.expiry}',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Icon(
                      selectedMethod?.id == method.id
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: selectedMethod?.id == method.id
                          ? AppColors.primary
                          : context.appPalette.muted,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
