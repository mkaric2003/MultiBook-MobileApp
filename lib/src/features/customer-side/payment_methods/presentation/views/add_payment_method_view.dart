import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/features/customer-side/payment_methods/cubit/payment_methods_cubit.dart';
import 'package:aquabook/src/features/customer-side/payment/domain/models/payment_input_formatters.dart';
import 'package:aquabook/src/features/customer-side/payment/presentation/widgets/payment_card_form.dart';
import 'package:aquabook/src/global_widgets/custom_app_bar.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:u_credit_card/u_credit_card.dart';

class AddPaymentMethodView extends HookWidget {
  const AddPaymentMethodView({super.key});
  @override
  Widget build(BuildContext context) {
    final number = useTextEditingController();
    final expiry = useTextEditingController();
    final cvv = useTextEditingController();
    final holder = useTextEditingController();
    useListenable(number);
    useListenable(expiry);
    useListenable(cvv);
    useListenable(holder);
    final enabled =
        PaymentInputValidation.isCardNumberValid(number.text) &&
        PaymentInputValidation.isExpiryValid(expiry.text) &&
        PaymentInputValidation.isCvvValid(cvv.text) &&
        holder.text.trim().isNotEmpty;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CustomAppBar(title: context.l10n.addPaymentMethod),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Center(
                      child: CreditCardUi(
                        cardHolderFullName: holder.text.isEmpty
                            ? context.l10n.cardholderNameExample
                            : holder.text,
                        cardNumber: number.text.isEmpty
                            ? '0000 0000 0000 0000'
                            : number.text,
                        validThru: expiry.text.isEmpty ? 'MM/YY' : expiry.text,
                        cvvNumber: cvv.text.isEmpty ? '***' : cvv.text,
                        showValidFrom: false,
                        doesSupportNfc: false,
                        enableFlipping: true,
                        topLeftColor: const Color(0xFF8B5CF6),
                        bottomRightColor: const Color(0xFF3B167B),
                      ),
                    ),
                    const SizedBox(height: 24),
                    PaymentCardForm(
                      cardNumber: number,
                      expiry: expiry,
                      cvv: cvv,
                      cardholder: holder,
                    ),
                    const Spacer(),
                    CustomButton(
                      buttonName: context.l10n.addPaymentMethod,
                      enabled: enabled,
                      onPressed: enabled
                          ? () async {
                              await getIt<PaymentMethodsCubit>().save(
                                number: number.text,
                                expiry: expiry.text,
                                holder: holder.text,
                              );
                              if (context.mounted) context.pop();
                            }
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
