import 'dart:typed_data';

import 'package:multibook/l10n/l10n.dart';
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: CircleAvatar(
              radius: 58,
              backgroundColor: context.appPalette.border,
              child: ClipOval(
                child: SizedBox(height: 110, width: 110, child: image),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: onTap,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              context.l10n.updateProfileImage,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
