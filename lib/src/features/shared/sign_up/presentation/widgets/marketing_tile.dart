import 'package:flutter/material.dart';
import 'package:multibook/src/core/theme/app_colors.dart';

class MarketingTile extends StatelessWidget {
  const MarketingTile({
    super.key,
    required this.value,
    required this.onChanged,
    this.label = 'Send me offers and updates',
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (v) => onChanged(v ?? false),
          side: BorderSide(color: context.appPalette.border, width: 1.5),
          activeColor: AppColors.primary,
          checkColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: context.appPalette.foreground,
              fontSize: 16,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}
