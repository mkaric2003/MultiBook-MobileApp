import 'dart:async';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/core/services/saved_business_updates_service.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/domain/use_cases/saved/get_saved_businesses_use_case.dart';
import 'package:multibook/src/domain/use_cases/saved/remove_saved_business_use_case.dart';
import 'package:multibook/src/features/customer-side/saved/cubit/saved_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SavedCubit extends Cubit<SavedState> {
  SavedCubit(this._getSaved, this._removeSaved, this._updates)
    : super(const SavedState()) {
    _subscription = _updates.changes.listen((_) => load());
  }
  final GetSavedBusinessesUseCase _getSaved;
  final RemoveSavedBusinessUseCase _removeSaved;
  final SavedBusinessUpdatesService _updates;
  late final StreamSubscription<void> _subscription;
  int _revision = 0;
  bool _removing = false;
  bool _refreshPending = false;
  Future<void> load() async {
    if (isClosed) return;
    if (_removing) {
      _refreshPending = true;
      return;
    }
    final revision = ++_revision;
    emit(SavedState(businesses: state.businesses, isLoading: true));
    final result = await _getSaved.execute();
    if (isClosed || revision != _revision) return;
    switch (result) {
      case Success(value: final items):
        emit(SavedState(businesses: items));
      case FailureResult():
        emit(SavedState(businesses: state.businesses, hasError: true));
    }
  }

  Future<bool> remove(BusinessModel business) async {
    if (_removing || isClosed) return false;
    _removing = true;
    ++_revision;
    final previous = state.businesses;
    emit(SavedState(businesses: previous, removingId: business.id));
    final result = await _removeSaved.execute(business.id);
    await Future<void>.delayed(const Duration(milliseconds: 280));
    _removing = false;
    final success = result is Success<void>;
    if (!isClosed) {
      emit(
        SavedState(
          businesses: success
              ? previous.where((x) => x.id != business.id).toList()
              : previous,
          hasError: !success,
        ),
      );
    }
    if (success) _updates.notifyChanged();
    if (_refreshPending) {
      _refreshPending = false;
      unawaited(load());
    }
    return success;
  }

  @override
  Future<void> close() async {
    ++_revision;
    await _subscription.cancel();
    return super.close();
  }
}
