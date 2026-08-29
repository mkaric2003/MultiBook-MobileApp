import 'dart:async';

import 'package:multibook/src/data/repositories/business_repository.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/enums/customer_home_tab.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:multibook/src/features/customer-side/search/cubit/customer_search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CustomerSearchCubit extends Cubit<CustomerSearchState> {
  CustomerSearchCubit(this._businessRepository)
    : super(const CustomerSearchState());

  final BusinessRepository _businessRepository;
  Timer? _searchDebounce;

  void selectTab(CustomerHomeTab tab) {
    _searchDebounce?.cancel();
    final query = state.query;
    emit(CustomerSearchState(selectedTab: tab, query: query));
    if (query.isNotEmpty) {
      _performSearch(query, tab);
    }
  }

  void search(String query) {
    _searchDebounce?.cancel();

    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) {
      emit(CustomerSearchState(selectedTab: state.selectedTab));
      return;
    }

    final selectedTab = state.selectedTab;

    _searchDebounce = Timer(
      const Duration(milliseconds: 450),
      () => _performSearch(trimmedQuery, selectedTab),
    );
  }

  Future<void> _performSearch(
    String trimmedQuery,
    CustomerHomeTab selectedTab,
  ) async {
    emit(
      CustomerSearchState(
        selectedTab: selectedTab,
        query: trimmedQuery,
        isLoading: true,
      ),
    );
    final businesses = selectedTab == CustomerHomeTab.stays
        ? await _businessRepository.searchStays(trimmedQuery)
        : await _businessRepository.searchServices(trimmedQuery);
    if (state.query != trimmedQuery || state.selectedTab != selectedTab) {
      return;
    }
    emit(
      CustomerSearchState(
        selectedTab: selectedTab,
        query: trimmedQuery,
        stays: selectedTab == CustomerHomeTab.stays
            ? businesses.map(StayListing.fromBusiness).toList()
            : const [],
        services: selectedTab == CustomerHomeTab.services
            ? businesses.map(ServiceListing.fromBusiness).toList()
            : const [],
      ),
    );
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }
}
