import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/features/customer-side/bookings/domain/enums/customer_booking_type.dart';
import 'package:multibook/src/features/customer-side/bookings/presentation/widgets/customer_booking_type_tab.dart';
import 'package:flutter/material.dart';

class CustomerBookingsTypeSelector extends StatelessWidget {
  const CustomerBookingsTypeSelector({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  final CustomerBookingType selectedType;
  final ValueChanged<CustomerBookingType> onChanged;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 14),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: context.appPalette.surfaceHighlight),
      ),
    ),
    child: Container(
      height: 52,
      decoration: BoxDecoration(
        color: context.appPalette.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomerBookingTypeTab(
              label: context.l10n.stays,
              selected: selectedType == CustomerBookingType.stays,
              onTap: () => onChanged(CustomerBookingType.stays),
            ),
          ),
          Expanded(
            child: CustomerBookingTypeTab(
              label: context.l10n.services,
              selected: selectedType == CustomerBookingType.services,
              onTap: () => onChanged(CustomerBookingType.services),
            ),
          ),
        ],
      ),
    ),
  );
}
