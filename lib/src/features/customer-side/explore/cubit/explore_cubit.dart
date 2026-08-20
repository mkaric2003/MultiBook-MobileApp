import 'package:aquabook/src/data/repositories/business_repository.dart';
import 'package:aquabook/src/data/repositories/user_repository.dart';
import 'package:aquabook/src/features/customer-side/explore/cubit/explore_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit(this._userRepository, this._businessRepository)
    : super(const ExploreState());

  final UserRepository _userRepository;
  final BusinessRepository _businessRepository;

  Future<void> load() async {
    final user = await _userRepository.getCurrentUser();
    final cities = await _businessRepository.getStayCities();
    final currentCity = user?.city?.trim();
    final allCities = {
      ...cities,
      if (currentCity?.isNotEmpty ?? false) currentCity!,
    }.toList()..sort();
    emit(
      ExploreState(
        isLoading: false,
        selectedCity: currentCity?.isNotEmpty ?? false ? currentCity! : null,
        cities: allCities,
      ),
    );
  }

  void selectCity(String city) {
    final trimmedCity = city.trim();
    final cities = {
      ...state.cities,
      if (trimmedCity.isNotEmpty) trimmedCity,
    }.toList()..sort();
    emit(
      state.copyWith(
        selectedCity: trimmedCity,
        clearSelectedCity: trimmedCity.isEmpty,
        cities: cities,
      ),
    );
  }
}
