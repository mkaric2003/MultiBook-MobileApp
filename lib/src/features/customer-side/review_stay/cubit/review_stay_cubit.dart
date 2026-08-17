import 'package:aquabook/src/data/models/stay_extra_model.dart';
import 'package:aquabook/src/data/repositories/business_repository.dart';
import 'package:aquabook/src/features/customer-side/review_stay/cubit/review_stay_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ReviewStayCubit extends Cubit<ReviewStayState> {
  ReviewStayCubit(this._repository) : super(const ReviewStayState());

  final BusinessRepository _repository;

  Future<void> loadStay(String id) async {
    emit(state.copyWith(isLoading: true));
    final business = await _repository.getBusiness(businessId: id);
    emit(state.copyWith(isLoading: false, business: business));
  }

  void toggleExtra(StayExtraModel extra) {
    final extras = [...state.selectedExtras];
    extras.contains(extra) ? extras.remove(extra) : extras.add(extra);
    emit(state.copyWith(selectedExtras: extras));
  }
}
