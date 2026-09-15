import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/data/models/user_model.dart';
import 'package:multibook/src/features/customer-side/profile/domain/models/customer_edit_profile_form_data.dart';
import 'package:multibook/src/features/customer-side/profile/presentation/widgets/customer_address_field.dart';
import 'package:multibook/src/features/customer-side/profile/presentation/widgets/customer_date_of_birth_picker_sheet.dart';
import 'package:multibook/src/global_widgets/custom_textfield.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

class CustomerEditProfileForm extends HookWidget {
  const CustomerEditProfileForm({super.key, this.user, this.onChanged});

  final UserModel? user;
  final ValueChanged<CustomerEditProfileFormData>? onChanged;

  @override
  Widget build(BuildContext context) {
    final firstNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final dateOfBirthController = useTextEditingController();
    final addressController = useTextEditingController();
    final cityController = useTextEditingController();
    final countryCode = useState('+1');
    final dateOfBirth = useState<DateTime?>(null);

    void notifyChanges() => onChanged?.call(
      CustomerEditProfileFormData(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phoneNumber: phoneController.text,
        countryCode: countryCode.value,
        dateOfBirth: dateOfBirth.value,
        address: addressController.text,
        city: cityController.text,
      ),
    );

    useEffect(() {
      firstNameController.text = user?.firstName ?? '';
      lastNameController.text = user?.lastName ?? '';
      emailController.text = user?.email ?? '';
      phoneController.text = user?.phoneNumber ?? '';
      countryCode.value = user?.countryCode ?? '+1';
      dateOfBirth.value = user?.dateOfBirth;
      dateOfBirthController.text = user?.dateOfBirth == null
          ? ''
          : DateFormat('dd. MM. yyyy.').format(user!.dateOfBirth!);
      addressController.text = user?.address ?? '';
      cityController.text = user?.city ?? '';
      return null;
    }, [user?.id]);

    Future<void> selectDateOfBirth() async {
      await showCupertinoModalPopup<void>(
        context: context,
        builder: (_) => Align(
          alignment: Alignment.bottomCenter,
          child: CustomerDateOfBirthPickerSheet(
            initialDate: dateOfBirth.value ?? DateTime(1995),
            onDateSelected: (selectedDate) {
              dateOfBirth.value = selectedDate;
              dateOfBirthController.text = DateFormat(
                'dd. MM. yyyy.',
              ).format(selectedDate);
              notifyChanges();
            },
          ),
        ),
      );
    }

    void selectCountryCode() {
      showCountryPicker(
        context: context,
        showPhoneCode: true,
        countryListTheme: CountryListThemeData(
          backgroundColor: context.appPalette.background,
          textStyle: TextStyle(
            color: context.appPalette.foreground,
            fontSize: 16,
          ),
          searchTextStyle: TextStyle(
            color: context.appPalette.foreground,
            fontSize: 16,
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          inputDecoration: InputDecoration(
            hintText: context.l10n.searchCountry,
            hintStyle: TextStyle(color: context.appPalette.muted),
            prefixIcon: Icon(Icons.search, color: context.appPalette.muted),
            filled: true,
            fillColor: context.appPalette.surface,
          ),
        ),
        onSelect: (country) {
          countryCode.value = '+${country.phoneCode}';
          notifyChanges();
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.l10n.firstNameRequired, style: _labelStyle(context)),
        const SizedBox(height: 10),
        CustomTextField(
          controller: firstNameController,
          hintText: context.l10n.firstName,
          onChanged: (_) => notifyChanges(),
        ),
        const SizedBox(height: 24),
        Text(context.l10n.lastNameRequired, style: _labelStyle(context)),
        const SizedBox(height: 10),
        CustomTextField(
          controller: lastNameController,
          hintText: context.l10n.lastName,
          onChanged: (_) => notifyChanges(),
        ),
        const SizedBox(height: 24),
        Text(context.l10n.emailAddressRequired, style: _labelStyle(context)),
        const SizedBox(height: 10),
        CustomTextField(
          controller: emailController,
          hintText: context.l10n.emailAddress,
          enabled: false,
          prefixIcon: Icons.email_outlined,
        ),
        const SizedBox(height: 24),
        Text(context.l10n.phoneNumber, style: _labelStyle(context)),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: selectCountryCode,
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  height: 56,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: context.appPalette.surface,
                    border: Border.all(color: context.appPalette.border),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        countryCode.value,
                        style: const TextStyle(fontSize: 16),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: context.appPalette.muted,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 4,
              child: CustomTextField(
                controller: phoneController,
                hintText: context.l10n.phoneNumberExample,
                keyboardType: TextInputType.phone,
                prefixIcon: Icons.phone_outlined,
                onChanged: (_) => notifyChanges(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(context.l10n.dateOfBirth, style: _labelStyle(context)),
        const SizedBox(height: 10),
        InkWell(
          onTap: selectDateOfBirth,
          borderRadius: BorderRadius.circular(14),
          child: IgnorePointer(
            child: CustomTextField(
              controller: dateOfBirthController,
              hintText: context.l10n.dateOfBirthExample,
              prefixIcon: Icons.calendar_today_outlined,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(context.l10n.cityOptional, style: _labelStyle(context)),
        const SizedBox(height: 10),
        CustomTextField(
          controller: cityController,
          hintText: context.l10n.enterCity,
          prefixIcon: Icons.location_city_outlined,
          onChanged: (_) => notifyChanges(),
        ),
        const SizedBox(height: 24),
        Text(context.l10n.addressOptional, style: _labelStyle(context)),
        const SizedBox(height: 10),
        CustomerAddressField(
          controller: addressController,
          onChanged: (_) => notifyChanges(),
        ),
      ],
    );
  }

  TextStyle _labelStyle(BuildContext context) => TextStyle(
    color: context.appPalette.foreground,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
}
