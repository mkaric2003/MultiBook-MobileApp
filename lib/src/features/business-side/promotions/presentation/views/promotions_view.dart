import 'package:multibook/app.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/business-side/promotions/bloc/promotions_cubit.dart';
import 'package:multibook/src/features/business-side/promotions/bloc/promotions_state.dart';
import 'package:multibook/src/global_widgets/custom_app_bar.dart';
import 'package:multibook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PromotionsView extends StatelessWidget {
  const PromotionsView({super.key});
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<PromotionsCubit>()..load(),
    child: Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CustomAppBar(title: context.l10n.promotionsAndDiscounts),
            Expanded(
              child: BlocBuilder<PromotionsCubit, PromotionsState>(
                builder: (context, state) {
                  if (state.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      Text(
                        state.business?.name ?? '',
                        style: const TextStyle(
                          color: AppColors.muted,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        context.l10n.activePromotions,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (state.promotions.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 48),
                          child: Center(
                            child: Text(
                              context.l10n.noPromotions,
                              style: const TextStyle(color: AppColors.muted),
                            ),
                          ),
                        ),
                      ...state.promotions.map(
                        (promotion) => Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      promotion.name,
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => context
                                        .read<PromotionsCubit>()
                                        .remove(promotion),
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: AppColors.muted,
                                    ),
                                  ),
                                  Switch(
                                    value: promotion.isActive,
                                    activeThumbColor: AppColors.primary,
                                    onChanged: (value) => context
                                        .read<PromotionsCubit>()
                                        .toggle(promotion, value),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                _value(
                                  context,
                                  promotion.type.name,
                                  promotion.value,
                                ),
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '${context.l10n.startsOn}: ${promotion.startsAt.day}.${promotion.startsAt.month}.${promotion.startsAt.year}  •  ${context.l10n.endsOn}: ${promotion.endsAt.day}.${promotion.endsAt.month}.${promotion.endsAt.year}',
                                style: const TextStyle(
                                  color: AppColors.muted,
                                  fontSize: 12,
                                ),
                              ),
                              if (promotion.code != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 7),
                                  child: Text(
                                    promotion.code!,
                                    style: const TextStyle(
                                      color: AppColors.muted,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      CustomButton(
                        buttonName: context.l10n.createPromotion,
                        onPressed: state.business == null
                            ? null
                            : () async {
                                final created = await context.push<bool>(
                                  AppRoutes.CREATE_PROMOTION,
                                  extra: state.business!,
                                );
                                if (created == true && context.mounted) {
                                  await context.read<PromotionsCubit>().load();
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

String _value(BuildContext context, String type, int value) =>
    type == 'percentage' ? '$value%' : context.l10n.formatCurrency(value);
