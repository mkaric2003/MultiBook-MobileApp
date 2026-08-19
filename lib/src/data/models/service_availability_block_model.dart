class ServiceAvailabilityBlockModel {
  const ServiceAvailabilityBlockModel({
    required this.id,
    required this.businessId,
    required this.providerId,
    required this.dateKey,
    required this.startMinutes,
  });

  final String id;
  final String businessId;
  final String providerId;
  final String dateKey;
  final int startMinutes;
}
