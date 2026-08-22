import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/data/enums/business_type.dart';
import 'package:aquabook/src/features/business-side/add_business/presentation/widgets/business_media/business_cover_photo_upload.dart';
import 'package:aquabook/src/features/business-side/add_business/presentation/widgets/business_media/business_logo_upload.dart';
import 'package:aquabook/src/features/business-side/add_business/presentation/widgets/business_media/business_photos_upload.dart';
import 'package:flutter/material.dart';

class BusinessMediaSection extends StatelessWidget {
  const BusinessMediaSection({
    super.key,
    required this.businessType,
    required this.logoPath,
    required this.coverPhotoPath,
    required this.businessPhotoPaths,
    required this.onLogoTap,
    required this.onCoverPhotoTap,
    required this.onBusinessPhotosTap,
    required this.onBusinessPhotoRemoved,
  });

  final BusinessType businessType;
  final String? logoPath;
  final String? coverPhotoPath;
  final List<String> businessPhotoPaths;
  final VoidCallback onLogoTap;
  final VoidCallback onCoverPhotoTap;
  final VoidCallback onBusinessPhotosTap;
  final ValueChanged<String> onBusinessPhotoRemoved;

  @override
  Widget build(BuildContext context) {
    final isService = businessType == BusinessType.services;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isService ? context.l10n.businessPhotos : context.l10n.businessImages,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 20),
        Text(
          context.l10n.businessLogo,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        BusinessLogoUpload(
          isService: isService,
          imagePath: logoPath,
          onTap: onLogoTap,
        ),
        const SizedBox(height: 22),
        Text(
          context.l10n.coverPhoto,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        BusinessCoverPhotoUpload(
          imagePath: coverPhotoPath,
          onTap: onCoverPhotoTap,
        ),
        const SizedBox(height: 22),
        BusinessPhotosUpload(
          imagePaths: businessPhotoPaths,
          onAdd: onBusinessPhotosTap,
          onRemove: onBusinessPhotoRemoved,
        ),
      ],
    );
  }
}
