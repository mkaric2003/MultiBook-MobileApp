import 'package:aquabook/app.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/features/shared/notifications/presentation/widgets/notification_bell.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomerHomeTopBar extends StatelessWidget {
  const CustomerHomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            context.l10n.appName,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
        ),
        NotificationBell(onTap: () => context.push(AppRoutes.NOTIFICATIONS)),
        const SizedBox(width: 20),
        const Icon(Icons.help_outline_rounded, size: 23),
      ],
    );
  }
}
