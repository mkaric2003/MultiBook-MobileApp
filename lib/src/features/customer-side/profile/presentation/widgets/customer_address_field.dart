import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:flutter/material.dart';

class CustomerAddressField extends StatelessWidget {
  const CustomerAddressField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 92,
    child: Stack(
      children: [
        TextField(
          controller: controller,
          expands: true,
          maxLines: null,
          minLines: null,
          onChanged: onChanged,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          textAlignVertical: TextAlignVertical.center,
          cursorColor: AppColors.primary,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.surface,
            hintText: context.l10n.enterAddress,
            hintStyle: TextStyle(color: AppColors.muted, fontSize: 16),
            contentPadding: EdgeInsets.fromLTRB(46, 16, 14, 16),
          ),
        ),
        const Positioned.fill(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsetsDirectional.only(start: 12),
              child: IgnorePointer(
                child: Icon(
                  Icons.location_on_outlined,
                  size: 20,
                  color: AppColors.muted,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
