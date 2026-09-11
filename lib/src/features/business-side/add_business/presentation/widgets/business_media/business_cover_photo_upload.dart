import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/features/business-side/add_business/presentation/widgets/business_media/picked_image_preview.dart';
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
          color: context.appPalette.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.appPalette.border),
        ),
        child: PickedImagePreview(
          imagePath: imagePath,
          fit: BoxFit.cover,
          fallback: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image_outlined,
                color: context.appPalette.iconMuted,
                size: 28,
              ),
              const SizedBox(height: 9),
              Text(
                context.l10n.uploadCoverPhoto,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                context.l10n.coverPhotoFormatHint,
                style: TextStyle(color: context.appPalette.muted, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
