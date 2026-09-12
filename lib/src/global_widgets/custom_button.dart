import 'dart:async';

import 'package:async_button_builder/async_button_builder.dart';
import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
    this.color = AppColors.primary,
    this.textColor,
    this.width,
    this.height,
    this.borderColor,
    this.leadingIcon,
    this.trailingIcon,
    this.enabled = true,
    this.disabledBackgroundColor,
    this.disabledTextColor,
    this.radius = 12,
    this.fontSize = 18,
    this.horizontalPadding = 24,
  });

  final String buttonName;
  final FutureOr<void> Function()? onPressed;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  final Color? borderColor;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool enabled;

  final Color? disabledBackgroundColor;
  final Color? disabledTextColor;
  final double radius;
  final double fontSize;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return AsyncButtonBuilder(
      onPressed: (enabled && onPressed != null)
          ? () async => await onPressed!()
          : null,
      showSuccess: false,
      loadingWidget: const SizedBox(
        height: 22,
        width: 22,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
      builder: (context, child, callback, state) {
        return ElevatedButton(
          onPressed: enabled ? callback : null,
          style: ButtonStyle(
            minimumSize: WidgetStateProperty.all(
              Size(width ?? double.infinity, height ?? 53),
            ),
            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(horizontal: horizontalPadding),
            ),
            elevation: WidgetStateProperty.all(0),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
                side: BorderSide(
                  color: borderColor ?? Colors.transparent,
                  width: borderColor == null ? 0 : 1,
                ),
              ),
            ),
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return disabledBackgroundColor ?? context.appPalette.border;
              }
              return color!;
            }),
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return disabledTextColor ?? context.appPalette.muted;
              }
              return textColor ??
                  ((color ?? AppColors.primary) == AppColors.primary
                      ? Colors.white
                      : context.appPalette.foreground);
            }),
            overlayColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.pressed)) {
                final fg =
                    textColor ??
                    ((color ?? AppColors.primary) == AppColors.primary
                        ? Colors.white
                        : context.appPalette.foreground);
                return fg.withValues(alpha: 0.08);
              }
              return null;
            }),
          ),
          child: child,
        );
      },
      child: leadingIcon == null && trailingIcon == null
          ? Text(
              buttonName,
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leadingIcon != null) ...[
                  IconTheme.merge(
                    data: const IconThemeData(size: 20),
                    child: leadingIcon!,
                  ),
                  const SizedBox(width: 8),
                ],
                Text(
                  buttonName,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
                if (trailingIcon != null) ...[
                  const SizedBox(width: 8),
                  IconTheme.merge(
                    data: const IconThemeData(size: 20),
                    child: trailingIcon!,
                  ),
                ],
              ],
            ),
    );
  }
}
