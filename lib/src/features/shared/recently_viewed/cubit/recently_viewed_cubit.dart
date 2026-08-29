import 'dart:async';

import 'package:multibook/src/data/repositories/recently_viewed_repository.dart';
import 'package:multibook/src/features/shared/recently_viewed/cubit/recently_viewed_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RecentlyViewedCubit extends Cubit<RecentlyViewedState> {
  RecentlyViewedCubit(this._repository) : super(const RecentlyViewedState()) {
    _changesSubscription = _repository.changes.listen((_) => load());
  }

  final RecentlyViewedRepository _repository;
  late final StreamSubscription<void> _changesSubscription;

  Future<void> load() async {
    final stays = await _repository.getRecentStays();
    if (!isClosed) emit(RecentlyViewedState(isLoading: false, stays: stays));
  }

  @override
  Future<void> close() async {
    await _changesSubscription.cancel();
    return super.close();
  }
}
