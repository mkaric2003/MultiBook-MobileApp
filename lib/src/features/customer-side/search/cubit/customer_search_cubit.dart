import 'dart:async';

import 'package:aquabook/src/data/repositories/business_repository.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/enums/customer_home_tab.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:aquabook/src/features/customer-side/search/cubit/customer_search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CustomerSearchCubit extends Cubit<CustomerSearchState> {
  CustomerSearchCubit(this._businessRepository)
    : super(const CustomerSearchState());

  final BusinessRepository _businessRepository;
  Timer? _searchDebounce;

  void selectTab(CustomerHomeTab tab) {
    emit(
      CustomerSearchState(
        selectedTab: tab,
        query: state.query,
        isLoading: false,
        stays: state.stays,
      ),
    );
  }

  void search(String query) {
    _searchDebounce?.cancel();

    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) {
      emit(CustomerSearchState(selectedTab: state.selectedTab));
      return;
    }

    _searchDebounce = Timer(
      const Duration(milliseconds: 450),
      () => _performSearch(trimmedQuery),
    );
  }

  Future<void> _performSearch(String trimmedQuery) async {
    emit(
      CustomerSearchState(
        selectedTab: state.selectedTab,
        query: trimmedQuery,
        isLoading: true,
      ),
    );
    final businesses = await _businessRepository.searchStays(trimmedQuery);
    if (state.query != trimmedQuery) {
      return;
    }
    emit(
      CustomerSearchState(
        selectedTab: state.selectedTab,
        query: trimmedQuery,
        stays: businesses.map(StayListing.fromBusiness).toList(),
      ),
    );
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }
}
