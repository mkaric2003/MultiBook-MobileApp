import 'package:multibook/src/data/repositories/service_search_repository.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/service_filters.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/service_listing.dart';
import 'package:multibook/src/features/customer-side/explore/cubit/explore_service_results_state.dart';
import 'package:multibook/src/features/customer-side/explore/domain/models/explore_service_results_arguments.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExploreServiceResultsCubit extends Cubit<ExploreServiceResultsState> {
  ExploreServiceResultsCubit(this._serviceSearchRepository)
    : super(const ExploreServiceResultsState());

  final ServiceSearchRepository _serviceSearchRepository;
  ExploreServiceResultsArguments? _arguments;
  String? _nextCursor;

  Future<void> load(ExploreServiceResultsArguments arguments) async {
    _arguments = arguments;
    _nextCursor = null;
    emit(const ExploreServiceResultsState());
    try {
      final results = await _serviceSearchRepository.search(
        filters: _filtersFor(arguments),
      );
      _nextCursor = results.nextCursor;
      emit(
        ExploreServiceResultsState(
          isLoading: false,
          hasMore: results.nextCursor != null,
          services: results.services.map(ServiceListing.fromBusiness).toList(),
        ),
      );
    } catch (_) {
      emit(const ExploreServiceResultsState(isLoading: false, hasMore: false));
    }
  }

  Future<void> loadMore() async {
    final arguments = _arguments;
    if (arguments == null ||
        state.isLoading ||
        state.isLoadingMore ||
        !state.hasMore) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));
    try {
      final results = await _serviceSearchRepository.search(
        filters: _filtersFor(arguments),
        cursor: _nextCursor,
      );
      final knownIds = state.services.map((service) => service.id).toSet();
      final additionalServices = results.services
          .map(ServiceListing.fromBusiness)
          .where((service) => knownIds.add(service.id))
          .toList();
      _nextCursor = results.nextCursor;
      emit(
        state.copyWith(
          isLoadingMore: false,
          hasMore: results.nextCursor != null,
          services: [...state.services, ...additionalServices],
        ),
      );
    } catch (_) {
      emit(state.copyWith(isLoadingMore: false));
    }
  }

  ServiceFilters _filtersFor(ExploreServiceResultsArguments arguments) =>
      ServiceFilters(
        city: arguments.city,
        categoryId: arguments.categoryId,
        collectionId: arguments.collectionId,
      );
}
