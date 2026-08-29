import 'package:multibook/src/data/enums/business_type.dart';

enum ClientBookingsTab { stays, services }

extension ClientBookingsTabX on ClientBookingsTab {
  BusinessType get businessType => this == ClientBookingsTab.stays
      ? BusinessType.stays
      : BusinessType.services;

  static ClientBookingsTab fromBusinessType(BusinessType type) =>
      type == BusinessType.stays
      ? ClientBookingsTab.stays
      : ClientBookingsTab.services;
}
