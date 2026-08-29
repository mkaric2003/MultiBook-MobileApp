import 'package:multibook/app.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/features/shared/notifications/presentation/widgets/notification_bell.dart';
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
      ],
    );
  }
}
