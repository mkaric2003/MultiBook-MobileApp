import 'package:aquabook/src/data/models/business_model.dart';

class DashboardState {
  const DashboardState({this.isLoading = true, this.business});

  final bool isLoading;
  final BusinessModel? business;
}
