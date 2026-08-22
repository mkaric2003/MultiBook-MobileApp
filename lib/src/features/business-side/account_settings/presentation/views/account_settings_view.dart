import 'package:aquabook/src/core/injectable/injectable.dart';
import 'package:aquabook/src/features/business-side/account_settings/bloc/account_settings_cubit.dart';
import 'package:aquabook/src/features/business-side/account_settings/bloc/account_settings_state.dart';
import 'package:aquabook/src/features/business-side/account_settings/presentation/widgets/account_settings_avatar.dart';
import 'package:aquabook/src/features/business-side/account_settings/presentation/widgets/account_settings_form.dart';
import 'package:aquabook/src/features/business-side/account_settings/presentation/widgets/account_settings_security_tile.dart';
import 'package:aquabook/src/features/business-side/account_settings/presentation/widgets/profile_image_source_picker_sheet.dart';
import 'package:aquabook/src/global_widgets/custom_app_bar.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AccountSettingsView extends HookWidget {
  const AccountSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final formData = useState<AccountSettingsFormData?>(null);

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
                CustomAppBar(title: context.l10n.accountSettings),
                Expanded(
                  child: state.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(35, 38, 35, 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Personal Information',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 30),
                              AccountSettingsAvatar(
                                imagePath: state.profileImagePath,
                                imageUrl: state.user?.profileImageUrl,
                                onTap: () => showModalBottomSheet<void>(
                                  context: context,
                                  builder: (sheetContext) =>
                                      ProfileImageSourcePickerSheet(
                                        onSourceSelected: (source) {
                                          Navigator.of(sheetContext).pop();
                                          context
                                              .read<AccountSettingsCubit>()
                                              .pickProfileImage(source);
                                        },
                                      ),
                                ),
                              ),
                              const SizedBox(height: 45),
                              AccountSettingsForm(
                                user: state.user,
                                onChanged: (data) => formData.value = data,
                              ),
                              const SizedBox(height: 55),
                              const Text(
                                'Security',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 27),
                              const AccountSettingsSecurityTile(),
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
                buttonName: 'Save Changes',
                enabled: !state.isSaving,
                onPressed: () async {
                  final data =
                      formData.value ??
                      AccountSettingsFormData(
                        firstName: state.user?.firstName ?? '',
                        lastName: state.user?.lastName ?? '',
                        phoneNumber: state.user?.phoneNumber ?? '',
                      );
                  await context.read<AccountSettingsCubit>().save(
                    firstName: data.firstName,
                    lastName: data.lastName,
                    phoneNumber: data.phoneNumber,
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
