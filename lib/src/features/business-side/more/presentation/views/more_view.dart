import 'package:aquabook/src/features/business-side/shared/presentation/widgets/client_placeholder_view.dart';
import 'package:flutter/material.dart';

class MoreView extends StatelessWidget {
  const MoreView({super.key, required this.onLogout});

  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const ClientPlaceholderView(title: 'More'),
        const SizedBox(height: 16),
        TextButton(onPressed: onLogout, child: const Text('Log out')),
      ],
    );
  }
}
