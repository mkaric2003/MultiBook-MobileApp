import 'package:multibook/app.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/customer-side/payment_methods/cubit/payment_methods_cubit.dart';
import 'package:multibook/src/features/customer-side/payment_methods/cubit/payment_methods_state.dart';
import 'package:multibook/src/features/customer-side/payment_methods/presentation/widgets/saved_payment_card.dart';
import 'package:multibook/src/global_widgets/custom_app_bar.dart';
import 'package:multibook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PaymentMethodsView extends StatelessWidget {
  const PaymentMethodsView({super.key});
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<PaymentMethodsCubit>()..load(),
    child: Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CustomAppBar(title: context.l10n.paymentMethods),
            Expanded(
              child: BlocBuilder<PaymentMethodsCubit, PaymentMethodsState>(
                builder: (context, state) {
                  if (state.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView(
                    padding: const EdgeInsets.fromLTRB(20, 22, 20, 32),
                    children: [
                      Text(
                        context.l10n.savedPaymentMethods,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        context.l10n.savedPaymentMethodsDescription,
                        style: const TextStyle(
                          color: AppColors.muted,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (state.methods.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 48),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.credit_card_off_outlined,
                                size: 46,
                                color: AppColors.muted,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                context.l10n.noSavedPaymentMethods,
                                style: const TextStyle(color: AppColors.muted),
                              ),
                            ],
                          ),
                        ),
                      ...state.methods.map(
                        (method) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: SavedPaymentCard(method: method),
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomButton(
                        buttonName: context.l10n.addPaymentMethod,
                        onPressed: () async {
                          final saved = await context.push<bool>(
                            AppRoutes.ADD_PAYMENT_METHOD,
                          );
                          if (saved == true && context.mounted) {
                            await context.read<PaymentMethodsCubit>().load();
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
