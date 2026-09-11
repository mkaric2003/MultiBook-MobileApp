import 'package:flutter/material.dart';

@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.background,
    required this.gradientStart,
    required this.gradientMiddle,
    required this.gradientEnd,
    required this.surface,
    required this.surfaceHighlight,
    required this.navigationSurface,
    required this.navigationBorder,
    required this.border,
    required this.muted,
    required this.iconMuted,
    required this.foreground,
  });

  static const dark = AppPalette(
    background: Color(0xFF111827),
    gradientStart: Color(0xFF111827),
    gradientMiddle: Color(0xFF111827),
    gradientEnd: Color(0xFF111827),
    surface: Color(0xFF1F2937),
    surfaceHighlight: Color(0xFF374151),
    navigationSurface: Color(0xFF374151),
    navigationBorder: Color(0xFF4B5563),
    border: Color(0xFF4B5563),
    muted: Color(0xFF9CA3AF),
    iconMuted: Color(0xFF6B7280),
    foreground: Color(0xFFFFFFFF),
  );

  static const light = AppPalette(
    background: Colors.white,
    gradientStart: Color(0x66E5F7F7),
    gradientMiddle: Color(0xFFB7E9E3),
    gradientEnd: Color(0xFF4FCAC0),
    surface: Color(0xFFFFFFFF),
    surfaceHighlight: Color(0xFFE2E8F0),
    navigationSurface: Color(0xFFDDF3F0),
    navigationBorder: Color(0xFFA8DDD7),
    border: Color(0xFFCBD5E1),
    muted: Color(0xFF64748B),
    iconMuted: Color(0xFF94A3B8),
    foreground: Color(0xFF111827),
  );

  final Color background;
  final Color gradientStart;
  final Color gradientMiddle;
  final Color gradientEnd;
  final Color surface;
  final Color surfaceHighlight;
  final Color navigationSurface;
  final Color navigationBorder;
  final Color border;
  final Color muted;
  final Color iconMuted;
  final Color foreground;

  @override
  AppPalette copyWith({
    Color? background,
    Color? gradientStart,
    Color? gradientMiddle,
    Color? gradientEnd,
    Color? surface,
    Color? surfaceHighlight,
    Color? navigationSurface,
    Color? navigationBorder,
    Color? border,
    Color? muted,
    Color? iconMuted,
    Color? foreground,
  }) => AppPalette(
    background: background ?? this.background,
    gradientStart: gradientStart ?? this.gradientStart,
    gradientMiddle: gradientMiddle ?? this.gradientMiddle,
    gradientEnd: gradientEnd ?? this.gradientEnd,
    surface: surface ?? this.surface,
    surfaceHighlight: surfaceHighlight ?? this.surfaceHighlight,
    navigationSurface: navigationSurface ?? this.navigationSurface,
    navigationBorder: navigationBorder ?? this.navigationBorder,
    border: border ?? this.border,
    muted: muted ?? this.muted,
    iconMuted: iconMuted ?? this.iconMuted,
    foreground: foreground ?? this.foreground,
  );

  @override
  AppPalette lerp(covariant AppPalette? other, double t) {
    if (other == null) return this;
    return AppPalette(
      background: Color.lerp(background, other.background, t)!,
      gradientStart: Color.lerp(gradientStart, other.gradientStart, t)!,
      gradientMiddle: Color.lerp(gradientMiddle, other.gradientMiddle, t)!,
      gradientEnd: Color.lerp(gradientEnd, other.gradientEnd, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceHighlight: Color.lerp(
        surfaceHighlight,
        other.surfaceHighlight,
        t,
      )!,
      navigationSurface: Color.lerp(
        navigationSurface,
        other.navigationSurface,
        t,
      )!,
      navigationBorder: Color.lerp(
        navigationBorder,
        other.navigationBorder,
        t,
      )!,
      border: Color.lerp(border, other.border, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      iconMuted: Color.lerp(iconMuted, other.iconMuted, t)!,
      foreground: Color.lerp(foreground, other.foreground, t)!,
    );
  }

  LinearGradient get backgroundGradient => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [gradientStart, gradientMiddle, gradientEnd],
  );
}

extension AppPaletteContext on BuildContext {
  AppPalette get appPalette => Theme.of(this).extension<AppPalette>()!;
}
