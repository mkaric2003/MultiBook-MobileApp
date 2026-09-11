import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/src/features/business-side/bookings/domain/enums/client_booking_filter.dart';
import 'package:flutter/material.dart';

class ClientBookingFilterChips extends StatelessWidget {
  const ClientBookingFilterChips({
    super.key,
    required this.selected,
    required this.onSelected,
  });
  final ClientBookingFilter selected;
  final ValueChanged<ClientBookingFilter> onSelected;
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        for (final filter in ClientBookingFilter.values)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(filter.label),
              selected: selected == filter,
              showCheckmark: false,
              onSelected: (_) => onSelected(filter),
              selectedColor: AppColors.primary,
              backgroundColor: context.appPalette.surfaceHighlight,
              labelStyle: TextStyle(
                color: selected == filter
                    ? Colors.white
                    : context.appPalette.muted,
                fontWeight: FontWeight.w700,
              ),
              side: BorderSide.none,
              shape: const StadiumBorder(),
            ),
          ),
      ],
    ),
  );
}
