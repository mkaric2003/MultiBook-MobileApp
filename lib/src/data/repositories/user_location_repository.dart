import 'package:aquabook/src/data/data_sources/device_location_data_source.dart';
import 'package:aquabook/src/data/data_sources/nominatim_data_source.dart';
import 'package:aquabook/src/data/enums/device_location_status.dart';
import 'package:aquabook/src/data/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

class UserLocationException implements Exception {
  const UserLocationException(this.message, {this.canOpenSettings = false});

  final String message;
  final bool canOpenSettings;
}

@lazySingleton
class UserLocationRepository {
  UserLocationRepository(
    this._deviceLocationDataSource,
    this._nominatimDataSource,
    this._userRepository,
  );

  final DeviceLocationDataSource _deviceLocationDataSource;
  final NominatimDataSource _nominatimDataSource;
  final UserRepository _userRepository;

  Future<bool> hasLocationPermission() =>
      _deviceLocationDataSource.hasLocationPermission();

  Future<void> updateCurrentUserLocation() async {
    final result = await _deviceLocationDataSource.requestCurrentLocation();
    if (!result.hasCoordinates) {
      throw UserLocationException(
        switch (result.status) {
          DeviceLocationStatus.serviceDisabled =>
            'Turn on Location Services to use your current location.',
          DeviceLocationStatus.permissionDeniedForever =>
            'Location access is disabled for MultiBook. Enable it in Settings.',
          DeviceLocationStatus.permissionDenied =>
            'Location permission was not granted.',
          _ => 'We could not get your current location.',
        },
        canOpenSettings:
            result.status == DeviceLocationStatus.permissionDeniedForever,
      );
    }

    final location = await _nominatimDataSource.reverseGeocode(
      latitude: result.latitude!,
      longitude: result.longitude!,
    );
    if (location == null || location.city.isEmpty || location.address.isEmpty) {
      throw const UserLocationException(
        'We could not determine your city and address.',
      );
    }

    await _userRepository.updateCurrentLocation(
      city: location.city,
      address: location.address,
    );
  }
}
