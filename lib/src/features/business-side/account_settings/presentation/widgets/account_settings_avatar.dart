import 'dart:typed_data';

import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';

class AccountSettingsAvatar extends HookWidget {
  const AccountSettingsAvatar({
    super.key,
    required this.imagePath,
    required this.imageUrl,
    required this.onTap,
  });

  final String? imagePath;
  final String? imageUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final imageBytes = useMemoized<Future<Uint8List>?>(
      () => imagePath == null ? null : XFile(imagePath!).readAsBytes(),
      [imagePath],
    );
    final snapshot = useFuture(imageBytes);
    final image = snapshot.hasData
        ? Image.memory(snapshot.data!, fit: BoxFit.cover)
        : (imageUrl?.isNotEmpty ?? false)
        ? Image.network(imageUrl!, fit: BoxFit.cover)
        : const Icon(Icons.person_rounded, size: 72, color: AppColors.muted);

    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: 72,
            backgroundColor: AppColors.border,
            child: ClipOval(
              child: SizedBox(height: 136, width: 136, child: image),
            ),
          ),
          Positioned(
            right: -2,
            bottom: 0,
            child: InkWell(
              onTap: onTap,
              customBorder: const CircleBorder(),
              child: Container(
                height: 55,
                width: 55,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.camera_alt_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
