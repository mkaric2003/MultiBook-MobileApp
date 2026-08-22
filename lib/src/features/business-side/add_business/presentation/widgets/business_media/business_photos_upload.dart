import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/business-side/add_business/presentation/widgets/business_media/business_photo_thumbnail.dart';
import 'package:flutter/material.dart';

class BusinessPhotosUpload extends StatelessWidget {
  const BusinessPhotosUpload({
    super.key,
    required this.imagePaths,
    required this.onAdd,
    required this.onRemove,
  });

  static const maxPhotos = 7;

  final List<String> imagePaths;
  final VoidCallback onAdd;
  final ValueChanged<String> onRemove;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Business photos (${imagePaths.length}/$maxPhotos)',
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          ...imagePaths.map(
            (imagePath) => BusinessPhotoThumbnail(
              imagePath: imagePath,
              onRemove: () => onRemove(imagePath),
            ),
          ),
          if (imagePaths.length < maxPhotos)
            InkWell(
              onTap: onAdd,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 86,
                width: 86,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_photo_alternate_outlined,
                      color: AppColors.primary,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Add photos',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      const SizedBox(height: 6),
      Text(
        context.l10n.addPhotosUpToSeven,
        style: TextStyle(color: AppColors.muted, fontSize: 12),
      ),
    ],
  );
}
