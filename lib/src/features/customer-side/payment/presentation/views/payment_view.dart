import 'package:aquabook/app.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/features/customer-side/booking_confirmed/domain/models/booking_confirmed_arguments.dart';
import 'package:aquabook/src/features/customer-side/payment/domain/models/payment_arguments.dart';
import 'package:aquabook/src/features/customer-side/payment/domain/models/payment_input_formatters.dart';
import 'package:aquabook/src/features/customer-side/payment/cubit/payment_cubit.dart';
import 'package:aquabook/src/features/customer-side/payment/cubit/payment_state.dart';
import 'package:aquabook/src/features/customer-side/payment/presentation/widgets/billing_information_form.dart';
import 'package:aquabook/src/features/customer-side/payment/presentation/widgets/payment_card_form.dart';
import 'package:aquabook/src/features/customer-side/payment/presentation/widgets/payment_price_breakdown.dart';
import 'package:aquabook/src/features/customer-side/payment/presentation/widgets/payment_wallet_option.dart';
import 'package:aquabook/src/global_widgets/custom_app_bar.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PaymentView extends HookWidget {
  const PaymentView({super.key, required this.arguments});
  final PaymentArguments arguments;
  @override
  Widget build(BuildContext context) {
    final cardNumber = useTextEditingController();
    final expiry = useTextEditingController();
    final cvv = useTextEditingController();
    final cardholder = useTextEditingController();
    final name = useTextEditingController();
    final email = useTextEditingController();
    final phone = useTextEditingController();
    final address = useTextEditingController();
    final agreed = useState(false);
    final paymentCubit = useMemoized(() => getIt<PaymentCubit>());
    useEffect(() => paymentCubit.close, [paymentCubit]);
    useListenable(cardNumber);
    useListenable(expiry);
    useListenable(cvv);
    final price =
        arguments.review.booking.pricePerNight ??
        arguments.review.booking.stay.pricePerNight ??
        0;
    final total = PaymentPriceBreakdown(
      arguments: arguments,
      pricePerNight: price,
    ).total();
    final isCardValid =
        PaymentInputValidation.isCardNumberValid(cardNumber.text) &&
        PaymentInputValidation.isExpiryValid(expiry.text) &&
        PaymentInputValidation.isCvvValid(cvv.text);
    return BlocProvider.value(
      value: paymentCubit,
      child: BlocListener<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state.booking != null) {
            context.go(
              AppRoutes.BOOKING_CONFIRMED,
              extra: BookingConfirmedArguments(
                payment: arguments,
                booking: state.booking!,
              ),
            );
          }
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Column(
              children: [
                CustomAppBar(title: context.l10n.payment),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(22, 24, 22, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PaymentPriceBreakdown(
                          arguments: arguments,
                          pricePerNight: price,
                        ),
                        const SizedBox(height: 30),
                        Text(
                          context.l10n.payment,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 18),
                        PaymentCardForm(
                          cardNumber: cardNumber,
                          expiry: expiry,
                          cvv: cvv,
                          cardholder: cardholder,
                        ),
                        const SizedBox(height: 14),
                        const PaymentWalletOption(
                          label: 'Apple Pay',
                          icon: Icon(Icons.apple, size: 27),
                        ),
                        const SizedBox(height: 14),
                        const PaymentWalletOption(
                          label: 'Google Pay',
                          icon: Text(
                            'G',
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          context.l10n.billingInformation,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 18),
                        BillingInformationForm(
                          name: name,
                          email: email,
                          phone: phone,
                          address: address,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Checkbox(
                              value: agreed.value,
                              onChanged: (value) =>
                                  agreed.value = value ?? false,
                              activeColor: AppColors.primary,
                            ),
                            Expanded(
                              child: Text(
                                context.l10n.agreeToTermsAndPrivacy,
                                style: const TextStyle(color: AppColors.muted),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(22, 12, 22, 22),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: AppColors.surfaceHighlight),
                    ),
                  ),
                  child: Column(
                    children: [
                      if (!agreed.value || !isCardValid)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            !agreed.value
                                ? context.l10n.acceptTermsToContinue
                                : 'Enter a valid 16-digit card, MM/YY and CVV.',
                            style: const TextStyle(
                              color: AppColors.muted,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      CustomButton(
                        buttonName: context.l10n.confirmAndPay('\$$total'),
                        enabled: agreed.value && isCardValid,
                        onPressed: () async => paymentCubit.confirm(arguments),
                      ),
                    ],
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
