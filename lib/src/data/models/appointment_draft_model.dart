class AppointmentDraftModel {
  const AppointmentDraftModel({
    required this.id,
    required this.businessId,
    required this.businessName,
    required this.businessImageUrl,
    required this.selectedOfferingIds,
    required this.date,
    this.startMinutes,
    this.selectedAddOnIds = const [],
  });

  final String id;
  final String businessId;
  final String businessName;
  final String businessImageUrl;
  final List<String> selectedOfferingIds;
  final DateTime date;
  final int? startMinutes;
  final List<String> selectedAddOnIds;
}
