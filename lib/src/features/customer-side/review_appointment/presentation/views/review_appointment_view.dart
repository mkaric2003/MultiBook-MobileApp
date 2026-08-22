import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/app.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/features/customer-side/create_appointment/cubit/appointment_draft_cubit.dart';
import 'package:aquabook/src/features/customer-side/review_appointment/domain/models/appointment_add_on.dart';
import 'package:aquabook/src/features/customer-side/review_appointment/domain/models/review_appointment_arguments.dart';
import 'package:aquabook/src/features/customer-side/review_appointment/presentation/widgets/appointment_add_on_tile.dart';
import 'package:aquabook/src/features/customer-side/review_appointment/presentation/widgets/appointment_price_summary.dart';
import 'package:aquabook/src/features/customer-side/review_appointment/presentation/widgets/appointment_review_summary_card.dart';
import 'package:aquabook/src/features/customer-side/appointment_payment/domain/models/appointment_payment_arguments.dart';
import 'package:aquabook/src/global_widgets/custom_app_bar.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class ReviewAppointmentView extends HookWidget {
  const ReviewAppointmentView({required this.arguments, super.key});

  final ReviewAppointmentArguments arguments;

  static const _addOns = [
    AppointmentAddOn(
      id: 'priority-service',
      name: 'Priority service',
      description: 'Extra attention and premium products.',
      price: 15,
    ),
    AppointmentAddOn(
      id: 'extended-consultation',
      name: 'Extended consultation',
      description: 'More time with your service provider.',
      price: 10,
    ),
    AppointmentAddOn(
      id: 'aftercare',
      name: 'Aftercare package',
      description: 'Tailored aftercare recommendations.',
      price: 8,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedAddOnIds = useState<Set<String>>(
      arguments.preselectedAddOnIds.toSet(),
    );
    final draftCubit = useMemoized(() => getIt<AppointmentDraftCubit>());
    useEffect(() => draftCubit.close, [draftCubit]);
    final selectedAddOns = _addOns
        .where((addOn) => selectedAddOnIds.value.contains(addOn.id))
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: 'Review appointment',
              onBackPressed: () async {
                final shouldSave = await showDialog<bool>(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    title: Text(context.l10n.saveAppointmentDraft),
                    content: const Text(
                      'You can continue this appointment later from Home.',
                    ),
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
                    addOnIds: selectedAddOnIds.value.toList(),
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
                    const Text(
                      'Available add-ons',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 14),
                    ..._addOns.map(
                      (addOn) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: AppointmentAddOnTile(
                          addOn: addOn,
                          isSelected: selectedAddOnIds.value.contains(addOn.id),
                          onChanged: (selected) {
                            final updated = {...selectedAddOnIds.value};
                            selected
                                ? updated.add(addOn.id)
                                : updated.remove(addOn.id);
                            selectedAddOnIds.value = updated;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    AppointmentPriceSummary(
                      offerings: arguments.offerings,
                      addOns: selectedAddOns,
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
                buttonName: 'Proceed to payment',
                onPressed: () => context.push(
                  AppRoutes.APPOINTMENT_PAYMENT,
                  extra: AppointmentPaymentArguments(
                    review: arguments,
                    selectedAddOns: selectedAddOns,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
