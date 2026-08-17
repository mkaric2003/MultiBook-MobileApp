import 'package:flutter/material.dart';

class StayDetailActionButton extends StatelessWidget {
  const StayDetailActionButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.iconColor = Colors.white,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      shape: const CircleBorder(),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: iconColor),
      ),
    );
  }
}
