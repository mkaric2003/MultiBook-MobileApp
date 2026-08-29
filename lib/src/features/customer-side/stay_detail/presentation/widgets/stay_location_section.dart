import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/features/customer-side/stay_detail/presentation/widgets/stay_location_map.dart';
import 'package:multibook/src/global_widgets/custom_button.dart';
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
          Text(
            context.l10n.location,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
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
                ? context.l10n.locationOnRequest
                : business.location.address,
            style: const TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 14),
          CustomButton(
            buttonName: context.l10n.openInMaps,
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.unableToOpenMaps)));
    }
  }
}
