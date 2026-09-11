import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTheme {
  static final dark = _theme(Brightness.dark, AppPalette.dark);
  static final light = _theme(Brightness.light, AppPalette.light);

  static ThemeData _theme(Brightness brightness, AppPalette palette) =>
      ThemeData(
        useMaterial3: true,
        brightness: brightness,
        scaffoldBackgroundColor: brightness == Brightness.light
            ? Colors.transparent
            : palette.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: brightness,
          primary: AppColors.primary,
          onPrimary: AppColors.white,
          surface: palette.surface,
          onSurface: palette.foreground,
          outline: palette.border,
          outlineVariant: palette.surfaceHighlight,
        ),
        textTheme: GoogleFonts.interTextTheme().apply(
          bodyColor: palette.foreground,
          displayColor: palette.foreground,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: brightness == Brightness.light
              ? Colors.transparent
              : palette.background,
          foregroundColor: palette.foreground,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: palette.surface,
          hintStyle: TextStyle(color: palette.muted),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: palette.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
        ),
        extensions: [palette],
      );
}
