import 'package:multibook/src/data/models/user_model.dart';
import 'package:multibook/src/data/enums/currency_code.dart';
import 'package:multibook/src/global_widgets/custom_textfield.dart';
import 'package:multibook/l10n/l10n.dart';
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
    final currency = useState(user?.businessCurrency ?? CurrencyCode.bam);

    useEffect(() {
      firstNameController.text = user?.firstName ?? '';
      lastNameController.text = user?.lastName ?? '';
      emailController.text = user?.email ?? '';
      phoneController.text = user?.phoneNumber ?? '';
      currency.value = user?.businessCurrency ?? CurrencyCode.bam;
      return null;
    }, [user?.id]);

    void notifyChanges() => onChanged?.call(
      AccountSettingsFormData(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phoneNumber: phoneController.text,
        businessCurrency: currency.value,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.l10n.firstNameRequired, style: _labelStyle),
        const SizedBox(height: 10),
        CustomTextField(
          controller: firstNameController,
          hintText: context.l10n.firstName,
          onChanged: (_) => notifyChanges(),
        ),
        const SizedBox(height: 20),
        Text(context.l10n.currency, style: _labelStyle),
        const SizedBox(height: 10),
        DropdownButtonFormField<CurrencyCode>(
          initialValue: currency.value,
          dropdownColor: const Color(0xFF1D1B2A),
          items: CurrencyCode.values
              .map(
                (value) => DropdownMenuItem(
                  value: value,
                  child: Text('${value.code} (${value.symbol})'),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value == null) return;
            currency.value = value;
            notifyChanges();
          },
        ),
        const SizedBox(height: 20),
        Text(context.l10n.lastNameRequired, style: _labelStyle),
        const SizedBox(height: 10),
        CustomTextField(
          controller: lastNameController,
          hintText: context.l10n.lastName,
          onChanged: (_) => notifyChanges(),
        ),
        const SizedBox(height: 20),
        Text(context.l10n.emailAddressRequired, style: _labelStyle),
        const SizedBox(height: 10),
        CustomTextField(
          controller: emailController,
          hintText: context.l10n.emailAddress,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 27),
        Text(context.l10n.phoneNumber, style: _labelStyle),
        const SizedBox(height: 10),
        CustomTextField(
          controller: phoneController,
          hintText: context.l10n.phoneNumberExample,
          keyboardType: TextInputType.phone,
          onChanged: (_) => notifyChanges(),
        ),
      ],
    );
  }

  static const _labelStyle = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
}

class AccountSettingsFormData {
  const AccountSettingsFormData({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.businessCurrency,
  });

  final String firstName;
  final String lastName;
  final String phoneNumber;
  final CurrencyCode businessCurrency;
}
