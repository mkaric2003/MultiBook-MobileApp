import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/data/models/service_offering_model.dart';
import 'package:multibook/src/features/customer-side/service_detail/presentation/widgets/service_offering_card.dart';
import 'package:flutter/material.dart';

class ServicesOfferedSection extends StatelessWidget {
  const ServicesOfferedSection({
    required this.business,
    required this.onBook,
    super.key,
  });

  final BusinessModel business;
  final ValueChanged<ServiceOfferingModel> onBook;

  @override
  Widget build(BuildContext context) {
    final offerings = (business.serviceDetails?.offerings ?? const [])
        .where((offering) => offering.isActive)
        .toList();
    if (offerings.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 26, 22, 24),
      color: Colors.white.withValues(alpha: 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.servicesOffered,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 16),
          ...offerings.map(
            (offering) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ServiceOfferingCard(
                offering: offering,
                onBook: () => onBook(offering),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
