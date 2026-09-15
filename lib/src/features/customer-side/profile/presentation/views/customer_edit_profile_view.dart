import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/features/business-side/account_settings/bloc/account_settings_cubit.dart';
import 'package:multibook/src/features/business-side/account_settings/bloc/account_settings_state.dart';
import 'package:multibook/src/features/customer-side/profile/domain/models/customer_edit_profile_form_data.dart';
import 'package:multibook/src/features/customer-side/profile/presentation/widgets/customer_edit_profile_form.dart';
import 'package:multibook/src/features/customer-side/profile/presentation/widgets/customer_profile_editor_avatar.dart';
import 'package:multibook/src/features/customer-side/profile/presentation/widgets/customer_profile_image_source_picker_sheet.dart';
import 'package:multibook/src/global_widgets/custom_app_bar.dart';
import 'package:multibook/src/global_widgets/custom_button.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomerEditProfileView extends HookWidget {
  const CustomerEditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final formData = useState<CustomerEditProfileFormData?>(null);

    return BlocProvider(
      create: (_) => getIt<AccountSettingsCubit>()..load(),
      child: BlocConsumer<AccountSettingsCubit, AccountSettingsState>(
        listener: (context, state) {
          final message = state.errorMessage ?? state.successMessage;
          if (message != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
          }
        },
        builder: (context, state) => Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                CustomAppBar(title: context.l10n.editProfile),
                Expanded(
                  child: state.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(35, 30, 35, 32),
                          child: Column(
                            children: [
                              CustomerProfileEditorAvatar(
                                imagePath: state.profileImagePath,
                                imageUrl: state.user?.profileImageUrl,
                                onTap: () => showModalBottomSheet<void>(
                                  context: context,
                                  builder: (sheetContext) =>
                                      CustomerProfileImageSourcePickerSheet(
                                        onSourceSelected: (source) {
                                          Navigator.of(sheetContext).pop();
                                          context
                                              .read<AccountSettingsCubit>()
                                              .pickProfileImage(source);
                                        },
                                      ),
                                ),
                              ),
                              const SizedBox(height: 38),
                              CustomerEditProfileForm(
                                user: state.user,
                                onChanged: (data) => formData.value = data,
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(35, 16, 35, 24),
              child: CustomButton(
                buttonName: context.l10n.saveChanges,
                enabled: !state.isSaving,
                onPressed: () async {
                  final data =
                      formData.value ??
                      CustomerEditProfileFormData(
                        firstName: state.user?.firstName ?? '',
                        lastName: state.user?.lastName ?? '',
                        phoneNumber: state.user?.phoneNumber ?? '',
                        countryCode: state.user?.countryCode ?? '+1',
                        dateOfBirth: state.user?.dateOfBirth,
                        address: state.user?.address ?? '',
                        city: state.user?.city ?? '',
                      );
                  await context.read<AccountSettingsCubit>().save(
                    firstName: data.firstName,
                    lastName: data.lastName,
                    phoneNumber: data.phoneNumber,
                    countryCode: data.countryCode,
                    dateOfBirth: data.dateOfBirth,
                    address: data.address,
                    city: data.city,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
