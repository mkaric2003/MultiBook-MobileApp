import 'package:aquabook/src/data/enums/business_type.dart';
import 'package:aquabook/src/features/business-side/add_business/presentation/widgets/business_media/business_cover_photo_upload.dart';
import 'package:aquabook/src/features/business-side/add_business/presentation/widgets/business_media/business_logo_upload.dart';
import 'package:flutter/material.dart';

class BusinessMediaSection extends StatelessWidget {
  const BusinessMediaSection({
    super.key,
    required this.businessType,
    required this.logoPath,
    required this.coverPhotoPath,
    required this.onLogoTap,
    required this.onCoverPhotoTap,
  });

  final BusinessType businessType;
  final String? logoPath;
  final String? coverPhotoPath;
  final VoidCallback onLogoTap;
  final VoidCallback onCoverPhotoTap;

  @override
  Widget build(BuildContext context) {
    final isService = businessType == BusinessType.services;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isService ? 'Business Photos' : 'Business Images',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 20),
        const Text(
          'Business logo',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        BusinessLogoUpload(
          isService: isService,
          imagePath: logoPath,
          onTap: onLogoTap,
        ),
        const SizedBox(height: 22),
        const Text(
          'Cover photo',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        BusinessCoverPhotoUpload(
          imagePath: coverPhotoPath,
          onTap: onCoverPhotoTap,
        ),
      ],
    );
  }
}
