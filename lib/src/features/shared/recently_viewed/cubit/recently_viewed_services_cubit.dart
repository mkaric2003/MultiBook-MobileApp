import 'dart:async';

import 'package:aquabook/src/data/repositories/recently_viewed_repository.dart';
import 'package:aquabook/src/features/shared/recently_viewed/cubit/recently_viewed_services_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RecentlyViewedServicesCubit extends Cubit<RecentlyViewedServicesState> {
  RecentlyViewedServicesCubit(this._repository)
    : super(const RecentlyViewedServicesState()) {
    _changesSubscription = _repository.changes.listen((_) => load());
  }

  final RecentlyViewedRepository _repository;
  late final StreamSubscription<void> _changesSubscription;

  Future<void> load() async {
    final services = await _repository.getRecentServices();
    if (!isClosed) {
      emit(RecentlyViewedServicesState(isLoading: false, services: services));
    }
  }

  @override
  Future<void> close() async {
    await _changesSubscription.cancel();
    return super.close();
  }
}
