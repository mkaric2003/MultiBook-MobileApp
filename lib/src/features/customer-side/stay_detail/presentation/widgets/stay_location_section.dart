import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/data/models/business_model.dart';
import 'package:aquabook/src/features/customer-side/stay_detail/presentation/widgets/stay_location_map.dart';
import 'package:aquabook/src/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StayLocationSection extends StatelessWidget {
  const StayLocationSection({super.key, required this.business});

  final BusinessModel business;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.surfaceHighlight)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Location',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 16),
          StayLocationMap(
            latitude: business.location.latitude,
            longitude: business.location.longitude,
            label: business.name,
          ),
          const SizedBox(height: 14),
          Text(
            business.location.address.isEmpty
                ? 'Location available on request'
                : business.location.address,
            style: const TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 14),
          CustomButton(
            buttonName: 'Open in Maps',
            color: Colors.transparent,
            borderColor: AppColors.border,
            onPressed: () => _openInGoogleMaps(context),
          ),
        ],
      ),
    );
  }

  Future<void> _openInGoogleMaps(BuildContext context) async {
    final location = business.location;
    final mapsUri = Uri.https('www.google.com', '/maps/search/', {
      'api': '1',
      'query': '${location.latitude},${location.longitude}',
    });
    final opened = await launchUrl(
      mapsUri,
      mode: LaunchMode.externalApplication,
    );
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to open Google Maps.')),
      );
    }
  }
}
