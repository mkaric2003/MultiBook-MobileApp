import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/models/user_model.dart';
import 'package:aquabook/src/features/customer-side/profile/domain/models/customer_edit_profile_form_data.dart';
import 'package:aquabook/src/features/customer-side/profile/presentation/widgets/customer_address_field.dart';
import 'package:aquabook/src/features/customer-side/profile/presentation/widgets/customer_date_of_birth_picker_sheet.dart';
import 'package:aquabook/src/global_widgets/custom_textfield.dart';
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
        countryListTheme: const CountryListThemeData(
          backgroundColor: AppColors.background,
          textStyle: TextStyle(color: Colors.white, fontSize: 16),
          searchTextStyle: TextStyle(color: Colors.white, fontSize: 16),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          inputDecoration: InputDecoration(
            hintText: 'Search country',
            hintStyle: TextStyle(color: AppColors.muted),
            prefixIcon: Icon(Icons.search, color: AppColors.muted),
            filled: true,
            fillColor: AppColors.surface,
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
        const Text('First Name*', style: _labelStyle),
        const SizedBox(height: 10),
        CustomTextField(
          controller: firstNameController,
          hintText: 'First name',
          onChanged: (_) => notifyChanges(),
        ),
        const SizedBox(height: 24),
        const Text('Last Name*', style: _labelStyle),
        const SizedBox(height: 10),
        CustomTextField(
          controller: lastNameController,
          hintText: 'Last name',
          onChanged: (_) => notifyChanges(),
        ),
        const SizedBox(height: 24),
        const Text('Email Address*', style: _labelStyle),
        const SizedBox(height: 10),
        CustomTextField(
          controller: emailController,
          hintText: 'Email address',
          enabled: false,
          prefixIcon: Icons.email_outlined,
        ),
        const SizedBox(height: 24),
        const Text('Phone Number', style: _labelStyle),
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
                    color: AppColors.surface,
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        countryCode.value,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.muted,
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
                hintText: '(555) 123-4567',
                keyboardType: TextInputType.phone,
                prefixIcon: Icons.phone_outlined,
                onChanged: (_) => notifyChanges(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text('Date of Birth', style: _labelStyle),
        const SizedBox(height: 10),
        InkWell(
          onTap: selectDateOfBirth,
          borderRadius: BorderRadius.circular(14),
          child: IgnorePointer(
            child: CustomTextField(
              controller: dateOfBirthController,
              hintText: 'DD. MM. YYYY.',
              prefixIcon: Icons.calendar_today_outlined,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text('City (optional)', style: _labelStyle),
        const SizedBox(height: 10),
        CustomTextField(
          controller: cityController,
          hintText: 'Enter your city',
          prefixIcon: Icons.location_city_outlined,
          onChanged: (_) => notifyChanges(),
        ),
        const SizedBox(height: 24),
        const Text('Address (optional)', style: _labelStyle),
        const SizedBox(height: 10),
        CustomerAddressField(
          controller: addressController,
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
