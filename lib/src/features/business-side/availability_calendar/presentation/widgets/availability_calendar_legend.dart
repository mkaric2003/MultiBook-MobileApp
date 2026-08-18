import 'package:aquabook/src/features/business-side/availability_calendar/presentation/widgets/availability_calendar_legend_item.dart';
import 'package:flutter/material.dart';

class AvailabilityCalendarLegend extends StatelessWidget {
  const AvailabilityCalendarLegend({super.key});

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 18,
    runSpacing: 12,
    children: const [
      AvailabilityCalendarLegendItem(
        label: 'Confirmed',
        color: Color(0xFF22C55E),
      ),
      AvailabilityCalendarLegendItem(
        label: 'Declined',
        color: Color(0xFFF59E0B),
      ),
      AvailabilityCalendarLegendItem(
        label: 'Completed',
        color: Color(0xFF8B5CF6),
      ),
      AvailabilityCalendarLegendItem(
        label: 'Cancelled',
        color: Color(0xFFFF4B4B),
      ),
    ],
  );
}
