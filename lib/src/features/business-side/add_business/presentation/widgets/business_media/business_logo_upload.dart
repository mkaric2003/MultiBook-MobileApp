import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/features/business-side/add_business/presentation/widgets/business_media/picked_image_preview.dart';
import 'package:flutter/material.dart';

class BusinessLogoUpload extends StatelessWidget {
  const BusinessLogoUpload({
    super.key,
    required this.isService,
    required this.imagePath,
    required this.onTap,
  });

  final bool isService;
  final String? imagePath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final avatar = InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(47),
      child: Container(
        height: isService ? 76 : 94,
        width: isService ? 76 : 94,
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border),
          color: AppColors.surface,
        ),
        child: PickedImagePreview(
          imagePath: imagePath,
          fit: BoxFit.cover,
          fallback: Icon(
            isService ? Icons.camera_alt : Icons.add,
            color: AppColors.iconMuted,
            size: isService ? 25 : 31,
          ),
        ),
      ),
    );

    if (!isService) {
      return avatar;
    }

    return Row(
      children: [
        avatar,
        const SizedBox(width: 16),
        InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.uploadLogo,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                context.l10n.logoFormatHint,
                style: const TextStyle(color: AppColors.muted, fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
