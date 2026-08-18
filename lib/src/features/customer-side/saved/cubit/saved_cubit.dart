import 'package:aquabook/src/data/repositories/saved_business_repository.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:aquabook/src/features/customer-side/saved/cubit/saved_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SavedCubit extends Cubit<SavedState> {
  SavedCubit(this._repository) : super(const SavedState());
  final SavedBusinessRepository _repository;
  Future<void> load() async {
    emit(SavedState(stays: await _repository.getSaved(), isLoading: false));
  }

  Future<void> remove(StayListing stay) async {
    if (state.removingId != null) return;
    emit(SavedState(stays: state.stays, isLoading: false, removingId: stay.id));
    await Future<void>.delayed(const Duration(milliseconds: 280));
    await _repository.toggle(stay, true);
    emit(
      SavedState(
        stays: state.stays.where((x) => x.id != stay.id).toList(),
        isLoading: false,
      ),
    );
  }
}
