import 'package:flutter/material.dart';

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
    const textColor = Color(0xFFE5E7EB);
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (v) => onChanged(v ?? false),
          side: const BorderSide(color: Colors.white, width: 1.5),
          activeColor: Color(0xFF7C3AED),
          checkColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: textColor,
              fontSize: 16,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}
