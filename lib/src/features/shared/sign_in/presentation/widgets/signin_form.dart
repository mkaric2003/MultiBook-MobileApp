import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/global_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SigninFormData {
  const SigninFormData({required this.email, required this.password});

  final String email;
  final String password;
}

class SigninForm extends HookWidget {
  const SigninForm({super.key, this.onValidityChanged, this.onChanged});

  final ValueChanged<bool>? onValidityChanged;
  final ValueChanged<SigninFormData>? onChanged;

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final showPassword = useState(false);

    useListenable(emailController);
    useListenable(passwordController);

    void notifyChanges() {
      final email = emailController.text.trim();
      final isValid =
          RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email) &&
          passwordController.text.isNotEmpty;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        onValidityChanged?.call(isValid);
        onChanged?.call(
          SigninFormData(email: email, password: passwordController.text),
        );
      });
    }

    useEffect(() {
      notifyChanges();
      return null;
    }, [emailController.text, passwordController.text]);

    const labelStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.l10n.emailAddressRequired, style: labelStyle),
        const SizedBox(height: 10),
        CustomTextField(
          hintText: context.l10n.enterYourEmail,
          prefixIcon: Icons.email_outlined,
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          onChanged: (_) => notifyChanges(),
        ),
        const SizedBox(height: 30),
        Text(context.l10n.passwordRequired, style: labelStyle),
        const SizedBox(height: 10),
        CustomTextField(
          hintText: context.l10n.enterYourPassword,
          prefixIcon: Icons.lock_outline,
          controller: passwordController,
          obscureText: !showPassword.value,
          suffixIcon: showPassword.value
              ? Icons.visibility
              : Icons.visibility_off,
          onSuffixTap: () => showPassword.value = !showPassword.value,
          onChanged: (_) => notifyChanges(),
        ),
      ],
    );
  }
}
