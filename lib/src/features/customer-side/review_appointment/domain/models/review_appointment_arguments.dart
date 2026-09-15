import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/data/models/service_offering_model.dart';
import 'package:multibook/src/data/models/service_provider_model.dart';

class ReviewAppointmentArguments {
  const ReviewAppointmentArguments({
    required this.business,
    required this.offerings,
    required this.date,
    required this.startMinutes,
    required this.provider,
    this.preselectedAddOnIds = const [],
  });

  final BusinessModel business;
  final List<ServiceOfferingModel> offerings;
  final DateTime date;
  final int startMinutes;
  final ServiceProviderModel provider;
  final List<String> preselectedAddOnIds;
}
