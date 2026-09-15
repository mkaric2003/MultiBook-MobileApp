import 'dart:developer';

import 'package:multibook/src/data/models/user_model.dart';
import 'package:multibook/src/data/repositories/user_location_repository.dart';
import 'package:multibook/src/features/shared/user_location/cubit/user_location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserLocationCubit extends Cubit<UserLocationState> {
  UserLocationCubit(this._userLocationRepository)
    : super(const UserLocationState());

  final UserLocationRepository _userLocationRepository;

  Future<void> initialize(UserModel? user) async {
    if (user == null) {
      emit(const UserLocationState(status: UserLocationStatus.complete));
      return;
    }

    if (await _userLocationRepository.hasLocationPermission()) {
      await useCurrentLocation();
      return;
    }

    emit(const UserLocationState(status: UserLocationStatus.needsPermission));
  }

  Future<void> useCurrentLocation() async {
    emit(const UserLocationState(status: UserLocationStatus.loading));
    try {
      await _userLocationRepository.updateCurrentUserLocation();
      emit(const UserLocationState(status: UserLocationStatus.complete));
    } on UserLocationException catch (error) {
      emit(
        UserLocationState(
          status: UserLocationStatus.error,
          errorMessage: error.message,
          canOpenSettings: error.canOpenSettings,
        ),
      );
    } on Exception catch (error, stackTrace) {
      log(
        'Unexpected location setup failure.',
        name: 'UserLocationCubit',
        error: error,
        stackTrace: stackTrace,
      );
      emit(
        const UserLocationState(
          status: UserLocationStatus.error,
          errorMessage: 'We could not save your current location.',
        ),
      );
    }
  }

  void skip() =>
      emit(const UserLocationState(status: UserLocationStatus.skipped));

  Future<void> openAppSettings() => Geolocator.openAppSettings();
}
