import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/global_widgets/custom_button.dart';
import 'package:multibook/src/features/customer-side/service_detail/presentation/widgets/service_location_map.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceLocationSection extends StatelessWidget {
  const ServiceLocationSection({required this.business, super.key});

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
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 14),
          ServiceLocationMap(
            latitude: business.location.latitude,
            longitude: business.location.longitude,
            label: business.name,
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(Icons.location_on, color: AppColors.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  [
                    business.location.address,
                    business.location.city,
                  ].where((value) => value.isNotEmpty).join(', '),
                  style: const TextStyle(color: AppColors.muted, fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          CustomButton(
            buttonName: context.l10n.openInMaps,
            color: Colors.transparent,
            borderColor: AppColors.border,
            onPressed: _openInGoogleMaps,
          ),
        ],
      ),
    );
  }

  Future<void> _openInGoogleMaps() async {
    final location = business.location;
    await launchUrl(
      Uri.https('www.google.com', '/maps/search/', {
        'api': '1',
        'query': '${location.latitude},${location.longitude}',
      }),
      mode: LaunchMode.externalApplication,
    );
  }
}
