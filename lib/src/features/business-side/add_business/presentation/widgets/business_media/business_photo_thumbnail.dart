import 'dart:io';

import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BusinessPhotoThumbnail extends StatelessWidget {
  const BusinessPhotoThumbnail({
    super.key,
    required this.imagePath,
    required this.onRemove,
  });

  final String imagePath;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 86,
    width: 86,
    child: Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: _isRemoteImage
              ? Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const SizedBox.shrink(),
                )
              : Image.file(File(imagePath), fit: BoxFit.cover),
        ),
        Positioned(
          top: 3,
          right: 3,
          child: InkWell(
            onTap: onRemove,
            borderRadius: BorderRadius.circular(14),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: context.appPalette.background,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close_rounded, size: 16),
            ),
          ),
        ),
      ],
    ),
  );

  bool get _isRemoteImage {
    final uri = Uri.tryParse(imagePath);
    return uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
  }
}
