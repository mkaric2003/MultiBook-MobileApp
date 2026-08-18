import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusinessLocationMap extends StatelessWidget {
  const BusinessLocationMap({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.onLocationSelected,
  });

  final double? latitude;
  final double? longitude;
  final ValueChanged<LatLng> onLocationSelected;

  static const _defaultLocation = LatLng(43.8563, 18.4131);

  @override
  Widget build(BuildContext context) {
    final selectedLocation = latitude == null || longitude == null
        ? null
        : LatLng(latitude!, longitude!);

    return Column(
      children: [
        SizedBox(
          height: 210,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: selectedLocation ?? _defaultLocation,
                zoom: 13,
              ),
              mapToolbarEnabled: false,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              markers: selectedLocation == null
                  ? const <Marker>{}
                  : {
                      Marker(
                        markerId: const MarkerId('business-location'),
                        position: selectedLocation,
                      ),
                    },
              onTap: onLocationSelected,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          selectedLocation == null
              ? 'Tap map to place pin'
              : 'Pin location selected',
          style: const TextStyle(
            color: AppColors.muted,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
