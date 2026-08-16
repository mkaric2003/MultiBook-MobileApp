import 'package:aquabook/src/data/repositories/business_repository.dart';
import 'package:aquabook/src/features/customer-side/dashboard/bloc/customer_dashboard_state.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/enums/customer_home_tab.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CustomerDashboardCubit extends Cubit<CustomerDashboardState> {
  CustomerDashboardCubit(this._businessRepository)
    : super(const CustomerDashboardState());

  final BusinessRepository _businessRepository;

  void selectTab(CustomerHomeTab tab) {
    emit(
      CustomerDashboardState(
        selectedTab: tab,
        isRecommendedStaysLoading: state.isRecommendedStaysLoading,
        recommendedStays: state.recommendedStays,
      ),
    );
  }

  Future<void> loadRecommendedStays() async {
    final recommendedBusinesses = await _businessRepository
        .getRecommendedStays();
    emit(
      CustomerDashboardState(
        selectedTab: state.selectedTab,
        isRecommendedStaysLoading: false,
        recommendedStays: recommendedBusinesses
            .map(StayListing.fromBusiness)
            .toList(),
      ),
    );
  }
}
