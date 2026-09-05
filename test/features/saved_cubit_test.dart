import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/core/services/saved_business_updates_service.dart';
import 'package:multibook/src/data/enums/business_type.dart';
import 'package:multibook/src/data/models/business_location_model.dart';
import 'package:multibook/src/data/models/business_model.dart';
import 'package:multibook/src/domain/repositories/saved_business_repository.dart';
import 'package:multibook/src/domain/use_cases/saved/get_saved_businesses_use_case.dart';
import 'package:multibook/src/domain/use_cases/saved/remove_saved_business_use_case.dart';
import 'package:multibook/src/features/customer-side/saved/cubit/saved_cubit.dart';

const business = BusinessModel(
  id: 'business',
  ownerId: 'owner',
  type: BusinessType.services,
  name: 'Service',
  categoryId: 'salon',
  location: BusinessLocationModel(address: '', latitude: 0, longitude: 0),
);

class SavedRepositoryStub implements SavedBusinessRepository {
  Result<void> removal = const Success(null);
  Result<List<BusinessModel>> items = const Success([business]);
  Future<Result<List<BusinessModel>>> Function()? pendingList;
  int reads = 0;
  @override
  Future<Result<List<BusinessModel>>> list() async {
    reads++;
    return pendingList?.call() ?? items;
  }

  @override
  Future<Result<void>> remove(String id) async {
    if (removal.isSuccess) items = const Success([]);
    return removal;
  }

  @override
  Future<Result<void>> save(String id) async => const Success(null);
  @override
  Future<Result<bool>> isSaved(String id) async => const Success(true);
}

void main() {
  test(
    'failed remove restores item and emits no refresh; success broadcasts',
    () async {
      final repository = SavedRepositoryStub();
      final updates = SavedBusinessUpdatesService();
      var events = 0;
      final subscription = updates.changes.listen((_) => events++);
      final cubit = SavedCubit(
        GetSavedBusinessesUseCase(repository),
        RemoveSavedBusinessUseCase(repository),
        updates,
      );
      await cubit.load();
      repository.removal = const FailureResult(NetworkFailure());
      final failed = cubit.remove(business);
      expect(cubit.state.removingId, business.id);
      expect(await failed, isFalse);
      expect(cubit.state.businesses.single.type, BusinessType.services);
      expect(cubit.state.hasError, isTrue);
      expect(events, 0);
      repository.removal = const Success(null);
      expect(await cubit.remove(business), isTrue);
      await Future<void>.delayed(Duration.zero);
      expect(cubit.state.businesses, isEmpty);
      expect(events, 1);
      await cubit.close();
      final reads = repository.reads;
      updates.notifyChanged();
      await Future<void>.delayed(Duration.zero);
      expect(repository.reads, reads);
      await subscription.cancel();
    },
  );
  test('stale list cannot resurrect a removed item', () async {
    final repository = SavedRepositoryStub();
    final cubit = SavedCubit(
      GetSavedBusinessesUseCase(repository),
      RemoveSavedBusinessUseCase(repository),
      SavedBusinessUpdatesService(),
    );
    await cubit.load();
    final pending = Completer<Result<List<BusinessModel>>>();
    repository.pendingList = () => pending.future;
    final loading = cubit.load();
    repository.pendingList = null;
    await cubit.remove(business);
    pending.complete(const Success([business]));
    await loading;
    await Future<void>.delayed(Duration.zero);
    expect(cubit.state.businesses, isEmpty);
    await cubit.close();
  });
  test('read failure keeps loaded cards', () async {
    final repository = SavedRepositoryStub();
    final cubit = SavedCubit(
      GetSavedBusinessesUseCase(repository),
      RemoveSavedBusinessUseCase(repository),
      SavedBusinessUpdatesService(),
    );
    await cubit.load();
    repository.items = const FailureResult(NetworkFailure());
    await cubit.load();
    expect(cubit.state.businesses.single.id, business.id);
    expect(cubit.state.hasError, isTrue);
    await cubit.close();
  });
}
