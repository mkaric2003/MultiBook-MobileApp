import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/features/shared/sign_up/presentation/widgets/password_requirement_item.dart';
import 'package:multibook/src/global_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupFormData {
  const SignupFormData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String password;
}

class SignUpForm extends HookWidget {
  const SignUpForm({super.key, this.onValidityChanged, this.onChanged});

  final ValueChanged<bool>? onValidityChanged;
  final ValueChanged<SignupFormData>? onChanged;

  @override
  Widget build(BuildContext context) {
    final firstNameCtrl = useTextEditingController();
    final lastNameCtrl = useTextEditingController();
    final emailCtrl = useTextEditingController();
    final passwordCtrl = useTextEditingController();
    final confirmPasswordCtrl = useTextEditingController();

    final showPassword = useState(false);
    final showConfirm = useState(false);

    useListenable(firstNameCtrl);
    useListenable(lastNameCtrl);
    useListenable(emailCtrl);
    useListenable(passwordCtrl);
    useListenable(confirmPasswordCtrl);

    bool computeValidity() {
      final pwd = passwordCtrl.text;
      final hasMinLength = pwd.length >= 8;
      final hasUppercase = RegExp(r'[A-Z]').hasMatch(pwd);
      final hasNumber = RegExp(r'\d').hasMatch(pwd);
      final hasSymbol = RegExp(r'[^\da-zA-Z]').hasMatch(pwd);

      final email = emailCtrl.text.trim();
      final emailOk = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email);
      final firstOk = firstNameCtrl.text.trim().isNotEmpty;
      final passwordsMatch =
          confirmPasswordCtrl.text == pwd &&
          confirmPasswordCtrl.text.isNotEmpty;
      final requirementsOk =
          hasMinLength && hasUppercase && hasNumber && hasSymbol;

      return firstOk && emailOk && requirementsOk && passwordsMatch;
    }

    void notifyValidity() {
      final v = computeValidity();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onValidityChanged?.call(v);
        onChanged?.call(
          SignupFormData(
            firstName: firstNameCtrl.text,
            lastName: lastNameCtrl.text,
            email: emailCtrl.text,
            password: passwordCtrl.text,
          ),
        );
      });
    }

    final pwd = passwordCtrl.text;
    final hasMinLength = pwd.length >= 8;
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(pwd);
    final hasNumber = RegExp(r'\d').hasMatch(pwd);
    final hasSymbol = RegExp(r'[^\da-zA-Z]').hasMatch(pwd);

    final score = [
      hasMinLength,
      hasUppercase,
      hasNumber,
      hasSymbol,
    ].where((b) => b).length;

    String strengthText;
    Color strengthColor;
    double strengthValue;
    if (pwd.isEmpty) {
      strengthText = '';
      strengthColor = context.appPalette.muted;
      strengthValue = 0.0;
    } else if (score <= 1) {
      strengthText = context.l10n.passwordWeak;
      strengthColor = const Color(0xFFF28B82);
      strengthValue = 0.18;
    } else if (score == 2) {
      strengthText = context.l10n.passwordFair;
      strengthColor = const Color(0xFFF59E0B);
      strengthValue = 0.5;
    } else if (score == 3) {
      strengthText = context.l10n.passwordGood;
      strengthColor = const Color(0xFF34D399);
      strengthValue = 0.75;
    } else {
      strengthText = context.l10n.passwordStrong;
      strengthColor = const Color(0xFF22C55E);
      strengthValue = 1.0;
    }

    useEffect(
      () {
        notifyValidity();
        return null;
      },
      [
        firstNameCtrl.text,
        lastNameCtrl.text,
        emailCtrl.text,
        passwordCtrl.text,
        confirmPasswordCtrl.text,
      ],
    );

    return Column(
      children: [
        CustomTextField(
          hintText: context.l10n.firstNameRequired,
          prefixIcon: Icons.person,
          controller: firstNameCtrl,
          onChanged: (_) => notifyValidity(),
        ),
        const SizedBox(height: 30),
        CustomTextField(
          hintText: context.l10n.lastName,
          prefixIcon: Icons.person,
          controller: lastNameCtrl,
          onChanged: (_) => notifyValidity(),
        ),
        const SizedBox(height: 30),
        CustomTextField(
          hintText: context.l10n.emailAddressRequired,
          prefixIcon: Icons.email,
          controller: emailCtrl,
          keyboardType: TextInputType.emailAddress,
          onChanged: (_) => notifyValidity(),
        ),
        const SizedBox(height: 30),
        CustomTextField(
          hintText: context.l10n.passwordRequired,
          prefixIcon: Icons.lock,
          controller: passwordCtrl,
          obscureText: !showPassword.value,
          suffixIcon: showPassword.value
              ? Icons.visibility
              : Icons.visibility_off,
          onSuffixTap: () => showPassword.value = !showPassword.value,
          onChanged: (_) => notifyValidity(),
        ),
        const SizedBox(height: 30),
        CustomTextField(
          hintText: context.l10n.confirmPasswordRequired,
          prefixIcon: Icons.lock,
          controller: confirmPasswordCtrl,
          obscureText: !showConfirm.value,
          suffixIcon: showConfirm.value
              ? Icons.visibility
              : Icons.visibility_off,
          onSuffixTap: () => showConfirm.value = !showConfirm.value,
          onChanged: (_) => notifyValidity(),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.l10n.passwordStrength,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: context.appPalette.muted,
              ),
            ),
            Text(
              strengthText.isEmpty ? ' ' : strengthText,
              style: GoogleFonts.inter(fontSize: 14, color: strengthColor),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 20),
          width: double.infinity,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: strengthValue),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            builder: (context, animated, _) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: animated,
                  minHeight: 10,
                  backgroundColor: context.appPalette.surfaceHighlight,
                  color: strengthColor,
                ),
              );
            },
          ),
        ),
        PasswordRequirementItem(
          label: context.l10n.atLeastEightCharacters,
          met: hasMinLength,
        ),
        const SizedBox(height: 12),
        PasswordRequirementItem(
          label: context.l10n.oneUppercaseLetter,
          met: hasUppercase,
        ),
        const SizedBox(height: 12),
        PasswordRequirementItem(label: context.l10n.oneNumber, met: hasNumber),
        const SizedBox(height: 12),
        PasswordRequirementItem(label: context.l10n.oneSymbol, met: hasSymbol),
        const SizedBox(height: 20),
      ],
    );
  }
}
