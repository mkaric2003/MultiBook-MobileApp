import 'package:flutter/material.dart';

@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.background,
    required this.surface,
    required this.surfaceHighlight,
    required this.border,
    required this.muted,
    required this.iconMuted,
    required this.foreground,
  });

  static const dark = AppPalette(
    background: Color(0xFF111827),
    surface: Color(0xFF1F2937),
    surfaceHighlight: Color(0xFF374151),
    border: Color(0xFF4B5563),
    muted: Color(0xFF9CA3AF),
    iconMuted: Color(0xFF6B7280),
    foreground: Color(0xFFFFFFFF),
  );

  static const light = AppPalette(
    background: Color(0xFFF8FAFC),
    surface: Color(0xFFFFFFFF),
    surfaceHighlight: Color(0xFFE2E8F0),
    border: Color(0xFFCBD5E1),
    muted: Color(0xFF64748B),
    iconMuted: Color(0xFF94A3B8),
    foreground: Color(0xFF111827),
  );

  final Color background;
  final Color surface;
  final Color surfaceHighlight;
  final Color border;
  final Color muted;
  final Color iconMuted;
  final Color foreground;

  @override
  AppPalette copyWith({
    Color? background,
    Color? surface,
    Color? surfaceHighlight,
    Color? border,
    Color? muted,
    Color? iconMuted,
    Color? foreground,
  }) => AppPalette(
    background: background ?? this.background,
    surface: surface ?? this.surface,
    surfaceHighlight: surfaceHighlight ?? this.surfaceHighlight,
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
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceHighlight: Color.lerp(
        surfaceHighlight,
        other.surfaceHighlight,
        t,
      )!,
      border: Color.lerp(border, other.border, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      iconMuted: Color.lerp(iconMuted, other.iconMuted, t)!,
      foreground: Color.lerp(foreground, other.foreground, t)!,
    );
  }
}

extension AppPaletteContext on BuildContext {
  AppPalette get appPalette => Theme.of(this).extension<AppPalette>()!;
}
