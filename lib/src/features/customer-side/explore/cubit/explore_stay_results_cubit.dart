import 'package:aquabook/src/data/repositories/stay_search_repository.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_filters.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:aquabook/src/features/customer-side/explore/cubit/explore_stay_results_state.dart';
import 'package:aquabook/src/features/customer-side/explore/domain/models/explore_stay_results_arguments.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExploreStayResultsCubit extends Cubit<ExploreStayResultsState> {
  ExploreStayResultsCubit(this._staySearchRepository)
    : super(const ExploreStayResultsState());

  final StaySearchRepository _staySearchRepository;

  Future<void> load(ExploreStayResultsArguments arguments) async {
    try {
      final results = await _staySearchRepository.search(
        filters: StayFilters(
          city: arguments.city,
          categoryIds: [arguments.categoryId],
        ),
      );
      emit(
        ExploreStayResultsState(
          isLoading: false,
          stays: results.stays.map(StayListing.fromBusiness).toList(),
        ),
      );
    } catch (_) {
      emit(const ExploreStayResultsState(isLoading: false));
    }
  }
}
