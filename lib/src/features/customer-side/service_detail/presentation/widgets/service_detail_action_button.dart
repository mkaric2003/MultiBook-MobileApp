import 'package:flutter/material.dart';

class ServiceDetailActionButton extends StatelessWidget {
  const ServiceDetailActionButton({
    required this.icon,
    this.onPressed,
    this.iconColor = Colors.white,
    super.key,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: const BoxDecoration(
        color: Colors.black54,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: iconColor),
      ),
    );
  }
}
