import 'package:multibook/src/data/repositories/stay_search_repository.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/stay_filters.dart';
import 'package:multibook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:multibook/src/features/customer-side/explore/cubit/explore_stay_results_state.dart';
import 'package:multibook/src/features/customer-side/explore/domain/models/explore_stay_results_arguments.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExploreStayResultsCubit extends Cubit<ExploreStayResultsState> {
  ExploreStayResultsCubit(this._staySearchRepository)
    : super(const ExploreStayResultsState());

  final StaySearchRepository _staySearchRepository;
  ExploreStayResultsArguments? _arguments;
  String? _nextCursor;

  Future<void> load(ExploreStayResultsArguments arguments) async {
    _arguments = arguments;
    _nextCursor = null;
    emit(const ExploreStayResultsState());
    try {
      final results = await _staySearchRepository.search(
        filters: StayFilters(
          city: arguments.city,
          categoryIds: arguments.categoryId.isEmpty
              ? const []
              : [arguments.categoryId],
          collectionIds: arguments.collectionId == null
              ? const []
              : [arguments.collectionId!],
        ),
      );
      emit(
        ExploreStayResultsState(
          isLoading: false,
          hasMore: results.nextCursor != null,
          stays: results.stays.map(StayListing.fromBusiness).toList(),
        ),
      );
      _nextCursor = results.nextCursor;
    } catch (_) {
      emit(const ExploreStayResultsState(isLoading: false, hasMore: false));
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
      final results = await _staySearchRepository.search(
        filters: _filtersFor(arguments),
        cursor: _nextCursor,
      );
      final existingIds = state.stays.map((stay) => stay.id).toSet();
      final additionalStays = results.stays
          .map(StayListing.fromBusiness)
          .where((stay) => existingIds.add(stay.id))
          .toList();
      _nextCursor = results.nextCursor;
      emit(
        state.copyWith(
          isLoadingMore: false,
          hasMore: results.nextCursor != null,
          stays: [...state.stays, ...additionalStays],
        ),
      );
    } catch (_) {
      emit(state.copyWith(isLoadingMore: false));
    }
  }

  StayFilters _filtersFor(ExploreStayResultsArguments arguments) => StayFilters(
    city: arguments.city,
    categoryIds: arguments.categoryId.isEmpty
        ? const []
        : [arguments.categoryId],
    collectionIds: arguments.collectionId == null
        ? const []
        : [arguments.collectionId!],
  );
}
