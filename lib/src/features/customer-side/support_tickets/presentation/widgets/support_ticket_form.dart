import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/enums/support_ticket_category.dart';
import 'package:multibook/src/global_widgets/custom_button.dart';
import 'package:multibook/src/global_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SupportTicketForm extends HookWidget {
  const SupportTicketForm({
    required this.isSubmitting,
    required this.onSubmit,
    super.key,
  });

  final bool isSubmitting;
  final void Function(
    SupportTicketCategory category,
    String subject,
    String message,
  )
  onSubmit;

  @override
  Widget build(BuildContext context) {
    final category = useState(SupportTicketCategory.other);
    final subjectController = useTextEditingController();
    final messageController = useTextEditingController();
    useListenable(subjectController);
    useListenable(messageController);
    final canSubmit =
        subjectController.text.trim().isNotEmpty &&
        messageController.text.trim().isNotEmpty &&
        !isSubmitting;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.supportRequestDescription,
          style: TextStyle(
            color: context.appPalette.muted,
            fontSize: 15,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 28),
        Text(
          context.l10n.selectSupportTopic,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: context.appPalette.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.appPalette.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<SupportTicketCategory>(
              value: category.value,
              isExpanded: true,
              dropdownColor: context.appPalette.surface,
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: context.appPalette.muted,
              ),
              style: TextStyle(
                color: context.appPalette.foreground,
                fontSize: 15,
              ),
              items: SupportTicketCategory.values
                  .map(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(_categoryLabel(context, value)),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) category.value = value;
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          context.l10n.supportSubject,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          controller: subjectController,
          hintText: context.l10n.supportSubjectHint,
        ),
        const SizedBox(height: 20),
        Text(
          context.l10n.supportMessage,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          controller: messageController,
          hintText: context.l10n.supportMessageHint,
          maxLines: 6,
        ),
        const SizedBox(height: 28),
        CustomButton(
          buttonName: context.l10n.sendSupportRequest,
          enabled: canSubmit,
          onPressed: () => onSubmit(
            category.value,
            subjectController.text,
            messageController.text,
          ),
        ),
      ],
    );
  }
}

String _categoryLabel(BuildContext context, SupportTicketCategory category) =>
    switch (category) {
      SupportTicketCategory.account => context.l10n.supportCategoryAccount,
      SupportTicketCategory.booking => context.l10n.supportCategoryBooking,
      SupportTicketCategory.appointment =>
        context.l10n.supportCategoryAppointment,
      SupportTicketCategory.payment => context.l10n.supportCategoryPayment,
      SupportTicketCategory.technical => context.l10n.supportCategoryTechnical,
      SupportTicketCategory.other => context.l10n.supportCategoryOther,
    };
