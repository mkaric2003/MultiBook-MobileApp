import 'package:multibook/src/data/models/business_model.dart';

class StaySearchResultModel {
  const StaySearchResultModel({required this.stays, required this.nextCursor});

  final List<BusinessModel> stays;
  final String? nextCursor;
}
