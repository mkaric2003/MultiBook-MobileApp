import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomerProfileImageSourcePickerSheet extends StatelessWidget {
  const CustomerProfileImageSourcePickerSheet({
    super.key,
    required this.onSourceSelected,
  });

  final ValueChanged<ImageSource> onSourceSelected;

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Update profile image',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library_outlined),
            title: const Text('Choose from library'),
            onTap: () => onSourceSelected(ImageSource.gallery),
          ),
          ListTile(
            leading: const Icon(Icons.photo_camera_outlined),
            title: const Text('Take a photo'),
            onTap: () => onSourceSelected(ImageSource.camera),
          ),
        ],
      ),
    ),
  );
}
