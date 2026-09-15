import 'package:flutter/material.dart';

class MoreMenuItem {
  const MoreMenuItem({
    required this.label,
    required this.icon,
    this.badgeCount,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final int? badgeCount;
  final VoidCallback? onTap;
}
