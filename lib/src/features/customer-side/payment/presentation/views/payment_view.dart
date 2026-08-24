import 'package:aquabook/app.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/data/enums/payment_method_type.dart';
import 'package:aquabook/src/features/customer-side/booking_confirmed/domain/models/booking_confirmed_arguments.dart';
import 'package:aquabook/src/features/customer-side/payment/domain/models/payment_arguments.dart';
import 'package:aquabook/src/features/customer-side/payment/domain/models/payment_input_formatters.dart';
import 'package:aquabook/src/features/customer-side/payment/cubit/payment_cubit.dart';
import 'package:aquabook/src/features/customer-side/payment/cubit/payment_state.dart';
import 'package:aquabook/src/features/customer-side/payment/presentation/widgets/billing_information_form.dart';
import 'package:aquabook/src/features/customer-side/payment/presentation/widgets/payment_card_form.dart';
import 'package:aquabook/src/features/customer-side/payment/presentation/widgets/payment_price_breakdown.dart';
import 'package:aquabook/src/features/customer-side/payment/presentation/widgets/payment_wallet_option.dart';
import 'package:aquabook/src/features/customer-side/payment_methods/cubit/payment_methods_cubit.dart';
import 'package:aquabook/src/features/customer-side/payment_methods/cubit/payment_methods_state.dart';
import 'package:aquabook/src/features/customer-side/payment_methods/domain/models/saved_payment_method_model.dart';
import 'package:aquabook/src/features/customer-side/payment_methods/presentation/widgets/saved_payment_method_selector.dart';
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
    final paymentType = useState(PaymentMethodType.card);
    final selectedMethod = useState<SavedPaymentMethodModel?>(null);
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
        selectedMethod.value != null ||
        (PaymentInputValidation.isCardNumberValid(cardNumber.text) &&
            PaymentInputValidation.isExpiryValid(expiry.text) &&
            PaymentInputValidation.isCvvValid(cvv.text));
    final isCashPayment = paymentType.value == PaymentMethodType.cash;
    final requiresCardDetails = paymentType.value == PaymentMethodType.card;
    final canConfirm = agreed.value && (!requiresCardDetails || isCardValid);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<PaymentCubit>()),
        BlocProvider(create: (_) => getIt<PaymentMethodsCubit>()..load()),
      ],
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
                        PaymentWalletOption(
                          label: context.l10n.creditDebitCard,
                          icon: const Icon(Icons.credit_card_rounded, size: 25),
                          isSelected:
                              paymentType.value == PaymentMethodType.card,
                          onTap: () =>
                              paymentType.value = PaymentMethodType.card,
                        ),
                        const SizedBox(height: 14),
                        if (paymentType.value == PaymentMethodType.card)
                          BlocBuilder<PaymentMethodsCubit, PaymentMethodsState>(
                            builder: (context, state) => Column(
                              children: [
                                SavedPaymentMethodSelector(
                                  methods: state.methods,
                                  selectedMethod: selectedMethod.value,
                                  onSelected: (method) =>
                                      selectedMethod.value = method,
                                ),
                                if (state.methods.isNotEmpty)
                                  const SizedBox(height: 14),
                                PaymentCardForm(
                                  cardNumber: cardNumber,
                                  expiry: expiry,
                                  cvv: cvv,
                                  cardholder: cardholder,
                                ),
                              ],
                            ),
                          ),
                        if (paymentType.value == PaymentMethodType.card)
                          const SizedBox(height: 14),
                        PaymentWalletOption(
                          label: 'Apple Pay',
                          icon: Icon(Icons.apple, size: 27),
                          isSelected:
                              paymentType.value == PaymentMethodType.applePay,
                          onTap: () =>
                              paymentType.value = PaymentMethodType.applePay,
                        ),
                        const SizedBox(height: 14),
                        PaymentWalletOption(
                          label: 'Google Pay',
                          icon: Text(
                            'G',
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          isSelected:
                              paymentType.value == PaymentMethodType.googlePay,
                          onTap: () =>
                              paymentType.value = PaymentMethodType.googlePay,
                        ),
                        const SizedBox(height: 14),
                        PaymentWalletOption(
                          label: context.l10n.payWithCash,
                          icon: const Icon(Icons.payments_outlined, size: 25),
                          isSelected:
                              paymentType.value == PaymentMethodType.cash,
                          onTap: () =>
                              paymentType.value = PaymentMethodType.cash,
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
                      if (!canConfirm)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            !agreed.value
                                ? context.l10n.acceptTermsToContinue
                                : context.l10n.validCardDetailsRequired,
                            style: const TextStyle(
                              color: AppColors.muted,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      CustomButton(
                        buttonName: isCashPayment
                            ? context.l10n.confirmBooking
                            : context.l10n.confirmAndPay(
                                context.l10n.formatCurrency(total),
                              ),
                        enabled: canConfirm,
                        onPressed: () async =>
                            context.read<PaymentCubit>().confirm(
                              arguments,
                              paymentType: paymentType.value,
                              paymentMethod: _paymentMethod(
                                paymentType.value,
                                cardNumber.text,
                                selectedMethod.value,
                              ),
                            ),
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

String _paymentMethod(
  PaymentMethodType type,
  String cardNumber,
  SavedPaymentMethodModel? selectedMethod,
) => switch (type) {
  PaymentMethodType.card =>
    selectedMethod == null
        ? 'Card ending in ${cardNumber.replaceAll(' ', '').substring(12)}'
        : 'Card ending in ${selectedMethod.last4}',
  PaymentMethodType.applePay => 'Apple Pay',
  PaymentMethodType.googlePay => 'Google Pay',
  PaymentMethodType.cash => 'cash',
};
