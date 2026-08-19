import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ServiceLocationMap extends StatelessWidget {
  const ServiceLocationMap({
    required this.latitude,
    required this.longitude,
    required this.label,
    super.key,
  });

  final double latitude;
  final double longitude;
  final String label;

  @override
  Widget build(BuildContext context) {
    final location = LatLng(latitude, longitude);
    return SizedBox(
      height: 175,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(target: location, zoom: 15),
          mapToolbarEnabled: false,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          markers: {
            Marker(
              markerId: const MarkerId('service-location'),
              position: location,
              infoWindow: InfoWindow(title: label),
            ),
          },
        ),
      ),
    );
  }
}
