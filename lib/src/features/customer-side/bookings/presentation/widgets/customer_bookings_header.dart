import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:flutter/material.dart';

class CustomerBookingsHeader extends StatelessWidget {
  const CustomerBookingsHeader({super.key});

  @override
  Widget build(BuildContext context) => Container(
    height: 86,
    padding: const EdgeInsets.symmetric(horizontal: 20),
    alignment: Alignment.centerLeft,
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: context.appPalette.surfaceHighlight),
      ),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            context.l10n.myBookings,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
          ),
        ),
      ],
    ),
  );
}
