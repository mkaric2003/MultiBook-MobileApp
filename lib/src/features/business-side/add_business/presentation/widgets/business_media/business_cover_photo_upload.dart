import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/business-side/add_business/presentation/widgets/business_media/picked_image_preview.dart';
import 'package:flutter/material.dart';

class BusinessCoverPhotoUpload extends StatelessWidget {
  const BusinessCoverPhotoUpload({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  final String? imagePath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 180,
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: PickedImagePreview(
          imagePath: imagePath,
          fit: BoxFit.cover,
          fallback: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.image_outlined, color: AppColors.iconMuted, size: 28),
              SizedBox(height: 9),
              Text(
                'Upload cover photo',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'JPG, PNG up to 10MB',
                style: TextStyle(color: AppColors.muted, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
