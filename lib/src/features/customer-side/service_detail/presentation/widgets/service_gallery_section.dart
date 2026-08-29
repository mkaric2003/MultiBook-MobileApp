import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/material.dart';

class ServiceGallerySection extends StatelessWidget {
  const ServiceGallerySection({required this.business, super.key});

  final BusinessModel business;

  @override
  Widget build(BuildContext context) {
    final images = <String>{
      if (business.coverPhotoUrl != null) business.coverPhotoUrl!,
      if (business.logoUrl != null) business.logoUrl!,
      ...business.photoUrls,
    }.toList();
    if (images.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.fromLTRB(22, 26, 0, 26),
      color: Colors.white.withValues(alpha: 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 22),
            child: Text(
              context.l10n.gallery,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              padding: const EdgeInsets.only(right: 22),
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) => ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  images[index],
                  height: 100,
                  width: 130,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
