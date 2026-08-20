import 'dart:developer';

import 'package:aquabook/src/data/enums/device_location_status.dart';
import 'package:aquabook/src/data/models/device_location_result.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

abstract class DeviceLocationDataSource {
  Future<bool> hasLocationPermission();

  Future<DeviceLocationResult> requestCurrentLocation();
}

@LazySingleton(as: DeviceLocationDataSource)
class DeviceLocationDataSourceImpl implements DeviceLocationDataSource {
  @override
  Future<bool> hasLocationPermission() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  @override
  Future<DeviceLocationResult> requestCurrentLocation() async {
    final isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return const DeviceLocationResult(
        status: DeviceLocationStatus.serviceDisabled,
      );
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      return const DeviceLocationResult(
        status: DeviceLocationStatus.permissionDenied,
      );
    }
    if (permission == LocationPermission.deniedForever) {
      return const DeviceLocationResult(
        status: DeviceLocationStatus.permissionDeniedForever,
      );
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
        ),
      );
      return DeviceLocationResult(
        status: DeviceLocationStatus.success,
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } on Exception catch (error, stackTrace) {
      log(
        'Could not get the device location.',
        name: 'DeviceLocationDataSource',
        error: error,
        stackTrace: stackTrace,
      );
      return const DeviceLocationResult(
        status: DeviceLocationStatus.unavailable,
      );
    }
  }
}
