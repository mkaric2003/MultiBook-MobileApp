import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onBackPressed,
    required this.hintText,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onBackPressed;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: const BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: onBackPressed,
            icon: const Icon(Icons.arrow_back, size: 26),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            height: 64,
            padding: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    onChanged: onChanged,
                    cursorColor: AppColors.primary,
                    style: const TextStyle(fontSize: 17),
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: const TextStyle(color: AppColors.muted),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      isCollapsed: true,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.clear();
                    onChanged('');
                  },
                  icon: const Icon(Icons.close, color: AppColors.muted),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
