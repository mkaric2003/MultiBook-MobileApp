import 'package:aquabook/src/data/repositories/onboarding_repository.dart';
import 'package:aquabook/src/features/shared/onboarding/cubit/onboarding_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(this._onboardingRepository) : super(const OnboardingState());

  final OnboardingRepository _onboardingRepository;

  void changePage(int page) => emit(OnboardingState(currentPage: page));

  Future<void> complete() async {
    await _onboardingRepository.completeOnboarding();
    emit(OnboardingState(currentPage: state.currentPage, isCompleted: true));
  }
}
