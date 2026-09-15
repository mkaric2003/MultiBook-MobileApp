import 'package:multibook/src/data/models/business_model.dart';

class ServiceSearchResultModel {
  const ServiceSearchResultModel({
    required this.services,
    required this.nextCursor,
  });

  final List<BusinessModel> services;
  final String? nextCursor;
}
