import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final FocusNode? focusNode;
  final bool enabled;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final int maxLines;

  const CustomTextField({
    super.key,
    this.hintText = '',
    this.controller,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.obscureText = false,
    this.focusNode,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextField(
      focusNode: focusNode,
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      enabled: enabled,
      maxLines: obscureText ? 1 : maxLines,
      style: TextStyle(color: colorScheme.onSurface, fontSize: 16),
      cursorColor: colorScheme.primary,
      decoration: InputDecoration(
        isDense: false,
        filled: true,
        fillColor: colorScheme.surface,
        hintText: hintText,
        hintStyle: TextStyle(color: context.appPalette.muted, fontSize: 16),
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: const EdgeInsetsDirectional.only(start: 12, end: 8),
                child: Icon(
                  prefixIcon,
                  size: 20,
                  color: context.appPalette.muted,
                ),
              )
            : null,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 44,
          minHeight: 44,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: onSuffixTap,
                splashRadius: 20,
                icon: Icon(
                  suffixIcon,
                  size: 20,
                  color: context.appPalette.muted,
                ),
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 14,
        ),
      ),
    );
  }
}
