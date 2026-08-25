import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/global_widgets/custom_textfield.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ChangePasswordForm extends HookWidget {
  const ChangePasswordForm({
    super.key,
    required this.isSubmitting,
    required this.onSubmit,
  });

  final bool isSubmitting;
  final Future<void> Function({
    required String currentPassword,
    required String newPassword,
  })
  onSubmit;

  @override
  Widget build(BuildContext context) {
    final currentController = useTextEditingController();
    final newController = useTextEditingController();
    final confirmationController = useTextEditingController();
    final isCurrentObscured = useState(true);
    final isNewObscured = useState(true);
    final isConfirmationObscured = useState(true);
    final validationMessage = useState<String?>(null);

    Future<void> submit() async {
      final currentPassword = currentController.text;
      final newPassword = newController.text;
      if (newPassword != confirmationController.text) {
        validationMessage.value = context.l10n.passwordsDoNotMatch;
        return;
      }
      validationMessage.value = null;
      await onSubmit(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.l10n.currentPassword, style: _labelStyle),
        const SizedBox(height: 10),
        CustomTextField(
          controller: currentController,
          hintText: context.l10n.currentPassword,
          obscureText: isCurrentObscured.value,
          suffixIcon: isCurrentObscured.value
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          onSuffixTap: () => isCurrentObscured.value = !isCurrentObscured.value,
        ),
        const SizedBox(height: 20),
        Text(context.l10n.newPassword, style: _labelStyle),
        const SizedBox(height: 10),
        CustomTextField(
          controller: newController,
          hintText: context.l10n.newPassword,
          obscureText: isNewObscured.value,
          suffixIcon: isNewObscured.value
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          onSuffixTap: () => isNewObscured.value = !isNewObscured.value,
        ),
        const SizedBox(height: 20),
        Text(context.l10n.confirmNewPassword, style: _labelStyle),
        const SizedBox(height: 10),
        CustomTextField(
          controller: confirmationController,
          hintText: context.l10n.confirmNewPassword,
          obscureText: isConfirmationObscured.value,
          suffixIcon: isConfirmationObscured.value
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          onSuffixTap: () =>
              isConfirmationObscured.value = !isConfirmationObscured.value,
        ),
        const SizedBox(height: 14),
        Text(
          context.l10n.passwordMinimumLength,
          style: const TextStyle(color: Colors.grey, fontSize: 13),
        ),
        if (validationMessage.value != null) ...[
          const SizedBox(height: 12),
          Text(
            validationMessage.value!,
            style: const TextStyle(color: Colors.redAccent, fontSize: 13),
          ),
        ],
        const SizedBox(height: 30),
        CustomButton(
          buttonName: context.l10n.saveChanges,
          enabled: !isSubmitting,
          onPressed: isSubmitting ? null : submit,
        ),
      ],
    );
  }

  static const _labelStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
}
