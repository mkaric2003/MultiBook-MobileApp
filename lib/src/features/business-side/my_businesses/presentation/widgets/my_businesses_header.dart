import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBusinessesHeader extends StatelessWidget {
  const MyBusinessesHeader({super.key});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(24, 22, 20, 18),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: AppColors.surfaceHighlight)),
    ),
    child: Row(
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(CupertinoIcons.back, size: 20),
        ),
        const SizedBox(width: 14),
        Text(
          context.l10n.myBusinesses,
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
        ),
      ],
    ),
  );
}
