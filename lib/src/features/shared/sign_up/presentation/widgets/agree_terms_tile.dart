import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AgreeTermsTile extends StatelessWidget {
  const AgreeTermsTile({
    super.key,
    required this.value,
    required this.onChanged,
    required this.onTapTerms,
    required this.onTapPrivacy,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final VoidCallback onTapTerms;
  final VoidCallback onTapPrivacy;

  @override
  Widget build(BuildContext context) {
    const baseColor = AppColors.muted;
    const linkColor = Color(0xFF7C3AED);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: value,
          onChanged: (v) => onChanged(v ?? false),
          side: const BorderSide(color: Colors.white, width: 1.5),
          activeColor: linkColor,
          checkColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text.rich(
            TextSpan(
              style: const TextStyle(
                color: baseColor,
                fontSize: 16,
                height: 1.35,
              ),
              children: [
                const TextSpan(text: 'I agree to the '),
                WidgetSpan(
                  baseline: TextBaseline.alphabetic,
                  alignment: PlaceholderAlignment.baseline,
                  child: InkWell(
                    onTap: onTapTerms,
                    child: const Text(
                      'Terms of Service',
                      style: TextStyle(
                        color: linkColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                const TextSpan(text: ' and\n'),
                WidgetSpan(
                  baseline: TextBaseline.alphabetic,
                  alignment: PlaceholderAlignment.baseline,
                  child: InkWell(
                    onTap: onTapPrivacy,
                    child: const Text(
                      'Privacy Policy',
                      style: TextStyle(
                        color: linkColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
