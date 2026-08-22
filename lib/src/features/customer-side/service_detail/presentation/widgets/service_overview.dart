import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/data/models/business_model.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:flutter/material.dart';

class ServiceOverview extends StatelessWidget {
  const ServiceOverview({
    required this.business,
    required this.service,
    super.key,
  });

  final BusinessModel business;
  final ServiceListing service;

  @override
  Widget build(BuildContext context) {
    final category = business.categoryId
        .split('_')
        .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            service.name,
            style: const TextStyle(fontSize: 27, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              category,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '⭐ ${service.rating.toStringAsFixed(1)} · ${context.l10n.reviews(service.reviewCount)}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.location_on, color: AppColors.primary, size: 19),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  '${service.location.isEmpty ? business.location.address : service.location} · 0.5 km ${context.l10n.away}',
                  style: const TextStyle(color: AppColors.muted, fontSize: 16),
                ),
              ),
            ],
          ),
          if (service.price != null) ...[
            const SizedBox(height: 22),
            Text(
              '${context.l10n.fromPrice('\$${service.price}')} ${context.l10n.perSession}',
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
            ),
          ],
        ],
      ),
    );
  }
}
