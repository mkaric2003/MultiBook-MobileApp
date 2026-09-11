import 'dart:typed_data';

import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';

class CustomerProfileEditorAvatar extends HookWidget {
  const CustomerProfileEditorAvatar({
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
        : Icon(Icons.person_rounded, size: 52, color: context.appPalette.muted);

    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: 52,
            backgroundColor: context.appPalette.border,
            child: ClipOval(
              child: SizedBox(height: 98, width: 98, child: image),
            ),
          ),
          Positioned(
            right: -4,
            bottom: -2,
            child: InkWell(
              onTap: onTap,
              customBorder: const CircleBorder(),
              child: Container(
                height: 42,
                width: 42,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.camera_alt_rounded, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
