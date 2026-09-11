import 'package:flutter/material.dart';
import 'package:multibook/src/core/theme/app_colors.dart';

class SocialSigninButton extends StatelessWidget {
  const SocialSigninButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.height = 60,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.radius = 24,
    this.enabled = true,
  });

  final String label;
  final Widget icon;
  final VoidCallback? onPressed;
  final double height;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final double radius;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: enabled
              ? backgroundColor ?? context.appPalette.surface
              : context.appPalette.surfaceHighlight,
          disabledBackgroundColor: context.appPalette.surfaceHighlight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: BorderSide(color: borderColor ?? context.appPalette.border),
          ),
          foregroundColor: textColor ?? context.appPalette.foreground,
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: IconTheme(
                  data: IconThemeData(
                    size: 22,
                    color: textColor ?? context.appPalette.foreground,
                  ),
                  child: icon,
                ),
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: textColor ?? context.appPalette.foreground,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
