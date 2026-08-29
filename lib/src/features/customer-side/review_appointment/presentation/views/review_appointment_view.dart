import 'package:multibook/app.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/customer-side/appointment_payment/domain/models/appointment_payment_arguments.dart';
import 'package:multibook/src/features/customer-side/appointment_payment/cubit/appointment_promotion_cubit.dart';
import 'package:multibook/src/features/customer-side/appointment_payment/cubit/appointment_promotion_state.dart';
import 'package:multibook/src/features/customer-side/create_appointment/cubit/appointment_draft_cubit.dart';
import 'package:multibook/src/features/customer-side/review_appointment/domain/models/review_appointment_arguments.dart';
import 'package:multibook/src/features/customer-side/review_appointment/presentation/widgets/appointment_price_summary.dart';
import 'package:multibook/src/features/customer-side/review_appointment/presentation/widgets/appointment_review_summary_card.dart';
import 'package:multibook/src/global_widgets/custom_app_bar.dart';
import 'package:multibook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class ReviewAppointmentView extends HookWidget {
  const ReviewAppointmentView({required this.arguments, super.key});

  final ReviewAppointmentArguments arguments;

  @override
  Widget build(BuildContext context) {
    final draftCubit = useMemoized(() => getIt<AppointmentDraftCubit>());
    useEffect(() => draftCubit.close, [draftCubit]);

    return BlocProvider(
      create: (_) =>
          getIt<AppointmentPromotionCubit>()..load(arguments.business.id),
      child: Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: context.l10n.reviewAppointment,
              onBackPressed: () async {
                final shouldSave = await showDialog<bool>(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    title: Text(context.l10n.saveAppointmentDraft),
                    content: Text(context.l10n.continueAppointmentLater),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext, false),
                        child: Text(context.l10n.discard),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext, true),
                        child: Text(context.l10n.saveDraft),
                      ),
                    ],
                  ),
                );
                if (shouldSave == true) {
                  await draftCubit.save(
                    business: arguments.business,
                    offeringIds: arguments.offerings
                        .map((offering) => offering.id)
                        .toList(),
                    providerId: arguments.provider.id,
                    providerName: arguments.provider.name,
                    date: arguments.date,
                    startMinutes: arguments.startMinutes,
                    addOnIds: const [],
                  );
                  if (context.mounted) context.go(AppRoutes.CUSTOMER_HOME);
                  return;
                }
                if (context.mounted) Navigator.of(context).pop();
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(22, 18, 22, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppointmentReviewSummaryCard(arguments: arguments),
                    const SizedBox(height: 26),
                    BlocBuilder<
                      AppointmentPromotionCubit,
                      AppointmentPromotionState
                    >(
                      builder: (context, state) => AppointmentPriceSummary(
                        offerings: arguments.offerings,
                        promotion: state.promotion,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(22, 16, 22, 22),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.surfaceHighlight),
                ),
              ),
              child: CustomButton(
                buttonName: context.l10n.proceedToPayment,
                onPressed: () => context.push(
                  AppRoutes.APPOINTMENT_PAYMENT,
                  extra: AppointmentPaymentArguments(review: arguments),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
  }
}
