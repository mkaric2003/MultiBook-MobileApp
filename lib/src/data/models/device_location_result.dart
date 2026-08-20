import 'package:aquabook/src/data/enums/device_location_status.dart';

class DeviceLocationResult {
  const DeviceLocationResult({
    required this.status,
    this.latitude,
    this.longitude,
  });

  final DeviceLocationStatus status;
  final double? latitude;
  final double? longitude;

  bool get hasCoordinates =>
      status == DeviceLocationStatus.success &&
      latitude != null &&
      longitude != null;
}
