import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multibook/src/core/injectable/injectable.dart';
import 'package:multibook/src/features/shared/notifications/cubit/notification_bell_cubit.dart';

class NotificationBell extends StatelessWidget {
  const NotificationBell({super.key, required this.onTap, this.size = 27});

  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<NotificationBellCubit>()..start(),
    child: BlocBuilder<NotificationBellCubit, int>(
      builder: (context, count) => IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        onPressed: onTap,
        icon: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(Icons.notifications_none_rounded, size: size),
            if (count > 0)
              Positioned(
                right: -7,
                top: -7,
                child: Container(
                  constraints: const BoxConstraints(minWidth: 18),
                  height: 18,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF05252),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    count > 9 ? '9+' : '$count',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}
