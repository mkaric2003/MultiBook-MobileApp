import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class OnboardingRepository {
  OnboardingRepository(this._sharedPreferences);

  static const _hasSeenOnboardingKey = 'has_seen_onboarding';

  final SharedPreferences _sharedPreferences;

  bool get hasSeenOnboarding =>
      _sharedPreferences.getBool(_hasSeenOnboardingKey) ?? false;

  Future<void> completeOnboarding() =>
      _sharedPreferences.setBool(_hasSeenOnboardingKey, true);
}
