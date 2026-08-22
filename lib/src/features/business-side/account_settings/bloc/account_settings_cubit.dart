import 'package:aquabook/src/data/data_sources/image_picker_data_source.dart';
import 'package:aquabook/src/data/enums/currency_code.dart';
import 'package:aquabook/src/data/repositories/user_repository.dart';
import 'package:aquabook/src/features/business-side/account_settings/bloc/account_settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class AccountSettingsCubit extends Cubit<AccountSettingsState> {
  AccountSettingsCubit(
    this._userRepository,
    this._imagePickerDataSource,
    this._sharedPreferences,
  ) : super(const AccountSettingsState());

  final UserRepository _userRepository;
  final ImagePickerDataSource _imagePickerDataSource;
  final SharedPreferences _sharedPreferences;
  static const _pendingProfileImageKey =
      'account_settings_pending_profile_image';

  Future<void> load() async {
    final user = await _userRepository.getCurrentUser();
    final profileImagePath = await _restoreLostProfileImage();
    emit(
      AccountSettingsState(
        isLoading: false,
        user: user,
        profileImagePath: profileImagePath,
      ),
    );
  }

  Future<void> pickProfileImage(ImageSource source) async {
    await _sharedPreferences.setBool(_pendingProfileImageKey, true);
    final image = await _imagePickerDataSource.pickImage(source: source);
    await _sharedPreferences.remove(_pendingProfileImageKey);

    if (image != null) {
      _emitProfileImagePath(image.path);
    }
  }

  Future<void> save({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? countryCode,
    DateTime? dateOfBirth,
    String? address,
    String? city,
    CurrencyCode? businessCurrency,
  }) async {
    if (state.isSaving) {
      return;
    }

    emit(
      AccountSettingsState(
        isLoading: false,
        isSaving: true,
        user: state.user,
        profileImagePath: state.profileImagePath,
      ),
    );

    try {
      final user = await _userRepository.updateProfile(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        profileImagePath: state.profileImagePath,
        countryCode: countryCode,
        dateOfBirth: dateOfBirth,
        address: address,
        city: city,
        businessCurrency: businessCurrency,
      );
      emit(
        AccountSettingsState(
          isLoading: false,
          user: user,
          successMessage: 'Profile updated successfully.',
        ),
      );
    } on UserException catch (error) {
      emit(
        AccountSettingsState(
          isLoading: false,
          user: state.user,
          profileImagePath: state.profileImagePath,
          errorMessage: error.message,
        ),
      );
    }
  }

  Future<String?> _restoreLostProfileImage() async {
    if (_sharedPreferences.getBool(_pendingProfileImageKey) != true) {
      return null;
    }

    final image = await _imagePickerDataSource.retrieveLostImage();
    await _sharedPreferences.remove(_pendingProfileImageKey);
    return image?.path;
  }

  void _emitProfileImagePath(String imagePath) {
    emit(
      AccountSettingsState(
        isLoading: false,
        user: state.user,
        profileImagePath: imagePath,
      ),
    );
  }
}
