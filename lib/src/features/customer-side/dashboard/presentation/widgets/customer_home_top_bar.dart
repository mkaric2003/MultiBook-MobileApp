import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multibook/app.dart';
import 'package:multibook/gen/assets.gen.dart';
import 'package:multibook/src/features/shared/notifications/presentation/widgets/notification_bell.dart';

class CustomerHomeTopBar extends StatelessWidget {
  const CustomerHomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Assets.images.multibook.image(
              height: 50,
              width: 170,
              fit: BoxFit.fitWidth,
              semanticLabel: 'MultiBook',
            ),
          ),
        ),
        NotificationBell(onTap: () => context.push(AppRoutes.NOTIFICATIONS)),
      ],
    );
  }
}
