import 'package:aquabook/src/data/repositories/business_repository.dart';
import 'package:aquabook/src/features/business-side/home/bloc/client_entry_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ClientEntryCubit extends Cubit<ClientEntryState> {
  ClientEntryCubit(this._businessRepository) : super(const ClientEntryState());

  final BusinessRepository _businessRepository;

  Future<void> load() async {
    final hasExistingBusiness = await _businessRepository.hasBusinesses();
    emit(
      ClientEntryState(
        isLoading: false,
        hasExistingBusiness: hasExistingBusiness,
      ),
    );
  }
}
