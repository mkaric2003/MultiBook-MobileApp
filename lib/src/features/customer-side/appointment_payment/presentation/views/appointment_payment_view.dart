import 'package:multibook/app.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/enums/payment_method_type.dart';
import 'package:multibook/src/features/customer-side/appointment_confirmed/domain/models/appointment_confirmed_arguments.dart';
import 'package:multibook/src/features/customer-side/appointment_payment/cubit/appointment_payment_cubit.dart';
import 'package:multibook/src/features/customer-side/appointment_payment/cubit/appointment_payment_state.dart';
import 'package:multibook/src/features/customer-side/appointment_payment/cubit/appointment_promotion_cubit.dart';
import 'package:multibook/src/features/customer-side/appointment_payment/cubit/appointment_promotion_state.dart';
import 'package:multibook/src/features/customer-side/appointment_payment/domain/models/appointment_payment_arguments.dart';
import 'package:multibook/src/features/customer-side/appointment_payment/domain/models/appointment_payment_request.dart';
import 'package:multibook/src/features/customer-side/appointment_payment/presentation/widgets/appointment_payment_price_breakdown.dart';
import 'package:multibook/src/features/customer-side/payment/domain/models/payment_input_formatters.dart';
import 'package:multibook/src/features/customer-side/payment/presentation/widgets/billing_information_form.dart';
import 'package:multibook/src/features/customer-side/payment/presentation/widgets/payment_card_form.dart';
import 'package:multibook/src/features/customer-side/payment/presentation/widgets/payment_wallet_option.dart';
import 'package:multibook/src/features/customer-side/payment_methods/cubit/payment_methods_cubit.dart';
import 'package:multibook/src/features/customer-side/payment_methods/cubit/payment_methods_state.dart';
import 'package:multibook/src/features/customer-side/payment_methods/domain/models/saved_payment_method_model.dart';
import 'package:multibook/src/features/customer-side/payment_methods/presentation/widgets/saved_payment_method_selector.dart';
import 'package:multibook/src/global_widgets/custom_app_bar.dart';
import 'package:multibook/src/global_widgets/custom_button.dart';
import 'package:multibook/src/global_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class AppointmentPaymentView extends HookWidget {
  const AppointmentPaymentView({required this.arguments, super.key});

  final AppointmentPaymentArguments arguments;

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
    final promoCode = useTextEditingController();
    final agreed = useState(false);
    final paymentType = useState(PaymentMethodType.card);
    final selectedMethod = useState<SavedPaymentMethodModel?>(null);

    useListenable(cardNumber);
    useListenable(expiry);
    useListenable(cvv);
    useListenable(cardholder);
    useListenable(name);
    useListenable(email);
    useListenable(phone);
    useListenable(promoCode);

    final isCardValid =
        selectedMethod.value != null ||
        (PaymentInputValidation.isCardNumberValid(cardNumber.text) &&
            PaymentInputValidation.isExpiryValid(expiry.text) &&
            PaymentInputValidation.isCvvValid(cvv.text) &&
            cardholder.text.trim().isNotEmpty);
    final hasCustomerInformation =
        name.text.trim().isNotEmpty &&
        email.text.trim().isNotEmpty &&
        phone.text.trim().isNotEmpty;
    final isCashPayment = paymentType.value == PaymentMethodType.cash;
    final requiresCardDetails = paymentType.value == PaymentMethodType.card;
    final canPay =
        agreed.value &&
        hasCustomerInformation &&
        (!requiresCardDetails || isCardValid);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AppointmentPaymentCubit>()),
        BlocProvider(create: (_) => getIt<PaymentMethodsCubit>()..load()),
        BlocProvider(
          create: (_) =>
              getIt<AppointmentPromotionCubit>()
                ..load(arguments.review.business.id),
        ),
      ],
      child: BlocListener<AppointmentPaymentCubit, AppointmentPaymentState>(
        listener: (context, state) {
          if (state.appointment != null) {
            context.go(
              AppRoutes.APPOINTMENT_CONFIRMED,
              extra: AppointmentConfirmedArguments(
                payment: arguments,
                appointment: state.appointment!,
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
          body: SafeArea(
            child: Column(
              children: [
                CustomAppBar(title: context.l10n.payment),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(22, 18, 22, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<
                          AppointmentPromotionCubit,
                          AppointmentPromotionState
                        >(
                          builder: (context, state) =>
                              AppointmentPaymentPriceBreakdown(
                                arguments: arguments,
                                promotion: state.promotion,
                              ),
                        ),
                        if (arguments.review.business.isPromotionActive) ...[
                          const SizedBox(height: 18),
                          Text(context.l10n.promoCodeOptional),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: promoCode,
                            hintText: context.l10n.promoCodeHint,
                          ),
                        ],
                        const SizedBox(height: 26),
                        Text(
                          context.l10n.payment,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 14),
                        PaymentWalletOption(
                          label: context.l10n.creditDebitCard,
                          icon: const Icon(Icons.credit_card_rounded, size: 24),
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
                          icon: Icon(Icons.apple, size: 25),
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
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
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
                          icon: const Icon(Icons.payments_outlined, size: 24),
                          isSelected:
                              paymentType.value == PaymentMethodType.cash,
                          onTap: () =>
                              paymentType.value = PaymentMethodType.cash,
                        ),
                        const SizedBox(height: 26),
                        Text(
                          context.l10n.customerInformation,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 14),
                        BillingInformationForm(
                          name: name,
                          email: email,
                          phone: phone,
                          address: address,
                          showAddress: false,
                        ),
                        const SizedBox(height: 18),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: agreed.value,
                              onChanged: (value) =>
                                  agreed.value = value ?? false,
                              activeColor: AppColors.primary,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 11),
                                child: Text(
                                  context.l10n.agreeToTermsAndPrivacy,
                                  style: TextStyle(
                                    color: context.appPalette.muted,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<
                  AppointmentPromotionCubit,
                  AppointmentPromotionState
                >(
                  builder: (context, promotionState) => Container(
                    padding: const EdgeInsets.fromLTRB(22, 12, 22, 22),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: context.appPalette.surfaceHighlight,
                        ),
                      ),
                    ),
                    child:
                        BlocBuilder<
                          AppointmentPaymentCubit,
                          AppointmentPaymentState
                        >(
                          builder: (context, state) => CustomButton(
                            buttonName: state.isProcessing
                                ? context.l10n.processingPayment
                                : isCashPayment
                                ? context.l10n.confirmBooking
                                : context.l10n.confirmAndPay(
                                    context.l10n.formatCurrency(
                                      arguments.totalWithPromotion(
                                        promotionState.promotion,
                                      ),
                                    ),
                                  ),
                            enabled: canPay && !state.isProcessing,
                            onPressed: () =>
                                context.read<AppointmentPaymentCubit>().confirm(
                                  arguments: arguments,
                                  request: AppointmentPaymentRequest(
                                    customerName: name.text,
                                    customerEmail: email.text,
                                    customerPhone: phone.text,
                                    paymentType: paymentType.value,
                                    paymentMethod: _paymentMethod(
                                      paymentType.value,
                                      cardNumber.text,
                                      selectedMethod.value,
                                    ),
                                  ),
                                  promoCode: promoCode.text,
                                ),
                          ),
                        ),
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
