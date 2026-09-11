import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:multibook/src/features/customer-side/service_detail/presentation/widgets/service_detail_action_button.dart';
import 'package:flutter/material.dart';

class ServiceDetailHero extends StatelessWidget {
  const ServiceDetailHero({
    required this.service,
    required this.onBack,
    required this.isSaved,
    required this.onSaved,
    super.key,
  });

  final ServiceListing service;
  final VoidCallback onBack;
  final bool isSaved;
  final VoidCallback onSaved;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 315,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            service.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) =>
                ColoredBox(color: context.appPalette.surfaceHighlight),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black45, Colors.transparent, Colors.black54],
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 18,
            child: ServiceDetailActionButton(
              icon: Icons.arrow_back,
              onPressed: onBack,
            ),
          ),
          const Positioned(
            top: 50,
            right: 76,
            child: ServiceDetailActionButton(icon: Icons.ios_share_outlined),
          ),
          Positioned(
            top: 50,
            right: 18,
            child: ServiceDetailActionButton(
              icon: isSaved ? Icons.favorite : Icons.favorite_border,
              iconColor: isSaved ? Colors.red : Colors.white,
              onPressed: onSaved,
            ),
          ),
        ],
      ),
    );
  }
}
