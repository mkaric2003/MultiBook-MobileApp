import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/material.dart';

class LabeledDivider extends StatelessWidget {
  const LabeledDivider({
    super.key,
    this.label,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  });

  final String? label;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: Divider(
              height: 1,
              thickness: 1,
              color: context.appPalette.surfaceHighlight,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            label ?? context.l10n.orContinueWith,
            style: TextStyle(color: context.appPalette.muted, fontSize: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Divider(
              height: 1,
              thickness: 1,
              color: context.appPalette.surfaceHighlight,
            ),
          ),
        ],
      ),
    );
  }
}
