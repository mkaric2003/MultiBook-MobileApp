import 'package:aquabook/src/data/models/user_model.dart';
import 'package:aquabook/src/global_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AccountSettingsForm extends HookWidget {
  const AccountSettingsForm({super.key, this.user, this.onChanged});

  final UserModel? user;
  final ValueChanged<AccountSettingsFormData>? onChanged;

  @override
  Widget build(BuildContext context) {
    final firstNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();

    useEffect(() {
      firstNameController.text = user?.firstName ?? '';
      lastNameController.text = user?.lastName ?? '';
      emailController.text = user?.email ?? '';
      phoneController.text = user?.phoneNumber ?? '';
      return null;
    }, [user?.id]);

    void notifyChanges() => onChanged?.call(
      AccountSettingsFormData(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phoneNumber: phoneController.text,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('First Name*', style: _labelStyle),
        const SizedBox(height: 10),
        CustomTextField(
          controller: firstNameController,
          hintText: 'First name',
          onChanged: (_) => notifyChanges(),
        ),
        const SizedBox(height: 27),
        const Text('Last Name*', style: _labelStyle),
        const SizedBox(height: 10),
        CustomTextField(
          controller: lastNameController,
          hintText: 'Last name',
          onChanged: (_) => notifyChanges(),
        ),
        const SizedBox(height: 27),
        const Text('Email Address*', style: _labelStyle),
        const SizedBox(height: 10),
        CustomTextField(
          controller: emailController,
          hintText: 'Email address',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 27),
        const Text('Phone Number', style: _labelStyle),
        const SizedBox(height: 10),
        CustomTextField(
          controller: phoneController,
          hintText: '+1 (555) 123-4567',
          keyboardType: TextInputType.phone,
          onChanged: (_) => notifyChanges(),
        ),
      ],
    );
  }

  static const _labelStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
}

class AccountSettingsFormData {
  const AccountSettingsFormData({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });

  final String firstName;
  final String lastName;
  final String phoneNumber;
}
