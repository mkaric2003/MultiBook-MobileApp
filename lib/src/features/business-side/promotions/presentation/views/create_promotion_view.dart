import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/features/business-side/promotions/domain/enums/promotion_type.dart';
import 'package:aquabook/src/features/business-side/promotions/bloc/create_promotion_cubit.dart';
import 'package:aquabook/src/features/business-side/promotions/bloc/create_promotion_state.dart';
import 'package:aquabook/src/features/business-side/promotions/presentation/widgets/promotion_date_picker_sheet.dart';
import 'package:aquabook/src/data/enums/business_type.dart';
import 'package:aquabook/src/data/models/business_model.dart';
import 'package:aquabook/src/global_widgets/custom_app_bar.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:aquabook/src/global_widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class CreatePromotionView extends HookWidget {
  const CreatePromotionView({required this.business, super.key});
  final BusinessModel business;

  @override
  Widget build(BuildContext context) {
    final name = useTextEditingController();
    final value = useTextEditingController();
    final code = useTextEditingController();
    final minimumNights = useTextEditingController(text: '1');
    final type = useState(PromotionType.percentage);
    final start = useState(DateTime.now());
    final end = useState(DateTime.now().add(const Duration(days: 30)));
    useListenable(name);
    useListenable(value);
    useListenable(code);
    useListenable(minimumNights);
    final isStay = business.type == BusinessType.stays;
    final valid =
        name.text.trim().isNotEmpty &&
        (int.tryParse(value.text) ?? 0) > 0 &&
        (type.value != PromotionType.couponCode || code.text.trim().isNotEmpty);
    return BlocProvider(
      create: (_) => getIt<CreatePromotionCubit>(),
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              CustomAppBar(title: context.l10n.createPromotion),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(context.l10n.promotionName),
                      const SizedBox(height: 8),
                      CustomTextField(
                        controller: name,
                        hintText: context.l10n.promotionNameHint,
                      ),
                      const SizedBox(height: 18),
                      Text(context.l10n.discountType),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<PromotionType>(
                        initialValue: type.value,
                        items: PromotionType.values
                            .map(
                              (item) => DropdownMenuItem(
                                value: item,
                                child: Text(_type(context, item)),
                              ),
                            )
                            .toList(),
                        onChanged: (item) => type.value = item ?? type.value,
                      ),
                      const SizedBox(height: 18),
                      Text(context.l10n.discountValue),
                      const SizedBox(height: 8),
                      CustomTextField(
                        controller: value,
                        hintText: context.l10n.discountValueHint,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 18),
                      Text(context.l10n.promoCodeOptional),
                      const SizedBox(height: 8),
                      CustomTextField(
                        controller: code,
                        hintText: context.l10n.promoCodeHint,
                      ),
                      if (isStay) ...[
                        const SizedBox(height: 18),
                        Text(context.l10n.minimumNights),
                        const SizedBox(height: 8),
                        CustomTextField(
                          controller: minimumNights,
                          hintText: context.l10n.minimumNights,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () =>
                                  showCupertinoModalPopup<DateTime>(
                                    context: context,
                                    builder: (_) => PromotionDatePickerSheet(
                                      title: context.l10n.startsOn,
                                      initialDate: start.value,
                                      minimumDate: DateTime.now(),
                                    ),
                                  ).then((date) {
                                    if (date != null) start.value = date;
                                  }),
                              child: Text(
                                '${context.l10n.startsOn}: ${start.value.day}.${start.value.month}.${start.value.year}',
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () =>
                                  showCupertinoModalPopup<DateTime>(
                                    context: context,
                                    builder: (_) => PromotionDatePickerSheet(
                                      title: context.l10n.endsOn,
                                      initialDate: end.value,
                                      minimumDate: start.value,
                                    ),
                                  ).then((date) {
                                    if (date != null) end.value = date;
                                  }),
                              child: Text(
                                '${context.l10n.endsOn}: ${end.value.day}.${end.value.month}.${end.value.year}',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      BlocConsumer<CreatePromotionCubit, CreatePromotionState>(
                        listener: (context, state) {
                          if (!state.submitting &&
                              state.errorMessage == null &&
                              context.mounted) {
                            context.pop();
                          }
                        },
                        builder: (context, state) => CustomButton(
                          buttonName: context.l10n.createPromotion,
                          enabled: valid && !state.submitting,
                          onPressed: () =>
                              context.read<CreatePromotionCubit>().create(
                                businessId: business.id,
                                name: name.text,
                                type: type.value,
                                value: int.parse(value.text),
                                startsAt: start.value,
                                endsAt: end.value,
                                code: code.text,
                                minimumAmount: 0,
                                minimumNights: isStay
                                    ? int.tryParse(minimumNights.text) ?? 1
                                    : 0,
                              ),
                        ),
                      ),
                    ],
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

String _type(BuildContext context, PromotionType type) => switch (type) {
  PromotionType.percentage => context.l10n.percentageDiscount,
  PromotionType.fixedAmount => context.l10n.fixedDiscount,
  PromotionType.couponCode => context.l10n.couponDiscount,
};
