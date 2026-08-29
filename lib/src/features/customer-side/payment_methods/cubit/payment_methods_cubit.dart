import 'dart:async';
import 'package:multibook/src/data/repositories/payment_methods_repository.dart';
import 'package:multibook/src/features/customer-side/payment_methods/cubit/payment_methods_state.dart';
import 'package:multibook/src/features/customer-side/payment_methods/domain/models/saved_payment_method_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  PaymentMethodsCubit(this._repository) : super(const PaymentMethodsState());
  final PaymentMethodsRepository _repository;
  StreamSubscription<List<SavedPaymentMethodModel>>? _subscription;
  void load() => _subscription = _repository.watch().listen(
    (methods) => emit(PaymentMethodsState(loading: false, methods: methods)),
  );
  Future<void> delete(String id) => _repository.delete(id);
  Future<void> setDefault(SavedPaymentMethodModel method) =>
      _repository.setDefault(method);
  Future<void> save({
    required String number,
    required String expiry,
    required String holder,
  }) =>
      _repository.save(cardNumber: number, expiry: expiry, holderName: holder);
  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
