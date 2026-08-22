import 'package:aquabook/app.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/appointment_confirmed/domain/models/appointment_confirmed_arguments.dart';
import 'package:aquabook/src/features/customer-side/appointment_payment/cubit/appointment_payment_cubit.dart';
import 'package:aquabook/src/features/customer-side/appointment_payment/cubit/appointment_payment_state.dart';
import 'package:aquabook/src/features/customer-side/appointment_payment/domain/models/appointment_payment_arguments.dart';
import 'package:aquabook/src/features/customer-side/appointment_payment/domain/models/appointment_payment_request.dart';
import 'package:aquabook/src/features/customer-side/appointment_payment/presentation/widgets/appointment_payment_price_breakdown.dart';
import 'package:aquabook/src/features/customer-side/payment/domain/models/payment_input_formatters.dart';
import 'package:aquabook/src/features/customer-side/payment/presentation/widgets/billing_information_form.dart';
import 'package:aquabook/src/features/customer-side/payment/presentation/widgets/payment_card_form.dart';
import 'package:aquabook/src/features/customer-side/payment/presentation/widgets/payment_wallet_option.dart';
import 'package:aquabook/src/global_widgets/custom_app_bar.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
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
    final agreed = useState(false);
    final paymentCubit = useMemoized(() => getIt<AppointmentPaymentCubit>());
    useEffect(() => paymentCubit.close, [paymentCubit]);

    useListenable(cardNumber);
    useListenable(expiry);
    useListenable(cvv);
    useListenable(cardholder);
    useListenable(name);
    useListenable(email);
    useListenable(phone);

    final isCardValid =
        PaymentInputValidation.isCardNumberValid(cardNumber.text) &&
        PaymentInputValidation.isExpiryValid(expiry.text) &&
        PaymentInputValidation.isCvvValid(cvv.text) &&
        cardholder.text.trim().isNotEmpty;
    final hasCustomerInformation =
        name.text.trim().isNotEmpty &&
        email.text.trim().isNotEmpty &&
        phone.text.trim().isNotEmpty;
    final canPay = agreed.value && isCardValid && hasCustomerInformation;

    return BlocProvider.value(
      value: paymentCubit,
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
          backgroundColor: AppColors.background,
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
                        AppointmentPaymentPriceBreakdown(arguments: arguments),
                        const SizedBox(height: 26),
                        Text(
                          context.l10n.payment,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 14),
                        PaymentCardForm(
                          cardNumber: cardNumber,
                          expiry: expiry,
                          cvv: cvv,
                          cardholder: cardholder,
                        ),
                        const SizedBox(height: 14),
                        const PaymentWalletOption(
                          label: 'Apple Pay',
                          icon: Icon(Icons.apple, size: 25),
                        ),
                        const SizedBox(height: 14),
                        const PaymentWalletOption(
                          label: 'Google Pay',
                          icon: Text(
                            'G',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
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
                                  style: const TextStyle(
                                    color: AppColors.muted,
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
                Container(
                  padding: const EdgeInsets.fromLTRB(22, 12, 22, 22),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: AppColors.surfaceHighlight),
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
                              : context.l10n.confirmAndPay(
                                  context.l10n.formatCurrency(arguments.total),
                                ),
                          enabled: canPay && !state.isProcessing,
                          onPressed: () => paymentCubit.confirm(
                            arguments: arguments,
                            request: AppointmentPaymentRequest(
                              customerName: name.text,
                              customerEmail: email.text,
                              customerPhone: phone.text,
                              paymentMethod:
                                  'Card ending in ${cardNumber.text.replaceAll(' ', '').substring(12)}',
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
