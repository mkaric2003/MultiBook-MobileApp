import 'package:aquabook/src/data/models/business_model.dart';
import 'package:aquabook/src/data/models/service_offering_model.dart';

class ReviewAppointmentArguments {
  const ReviewAppointmentArguments({
    required this.business,
    required this.offerings,
    required this.date,
    required this.startMinutes,
    this.preselectedAddOnIds = const [],
  });

  final BusinessModel business;
  final List<ServiceOfferingModel> offerings;
  final DateTime date;
  final int startMinutes;
  final List<String> preselectedAddOnIds;
}
