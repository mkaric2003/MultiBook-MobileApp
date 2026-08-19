import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/business-side/bookings/domain/enums/client_bookings_tab.dart';
import 'package:flutter/material.dart';

class ClientBookingsTypeTabs extends StatelessWidget {
  const ClientBookingsTypeTabs({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final ClientBookingsTab selected;
  final ValueChanged<ClientBookingsTab> onChanged;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.fromLTRB(20, 12, 20, 0),
    height: 44,
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        for (final tab in ClientBookingsTab.values)
          Expanded(
            child: InkWell(
              onTap: () => onChanged(tab),
              borderRadius: BorderRadius.circular(9),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected == tab
                      ? AppColors.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Text(
                  tab.label,
                  style: TextStyle(
                    color: selected == tab ? Colors.white : AppColors.muted,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
      ],
    ),
  );
}
