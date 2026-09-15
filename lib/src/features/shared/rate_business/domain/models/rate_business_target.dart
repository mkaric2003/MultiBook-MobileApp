enum RateBusinessTargetType { stay, service }

class RateBusinessTarget {
  const RateBusinessTarget.stay({
    required this.businessId,
    required this.sourceId,
    required this.businessName,
  }) : type = RateBusinessTargetType.stay;

  const RateBusinessTarget.service({
    required this.businessId,
    required this.sourceId,
    required this.businessName,
  }) : type = RateBusinessTargetType.service;

  final RateBusinessTargetType type;
  final String businessId;
  final String sourceId;
  final String businessName;
}
