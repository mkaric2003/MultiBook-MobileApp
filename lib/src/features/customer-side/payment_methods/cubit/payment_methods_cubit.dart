import 'package:multibook/src/core/errors/result.dart';
import 'package:multibook/src/domain/use_cases/payment_methods/delete_payment_method_use_case.dart';
import 'package:multibook/src/domain/use_cases/payment_methods/get_payment_methods_use_case.dart';
import 'package:multibook/src/domain/use_cases/payment_methods/save_payment_method_use_case.dart';
import 'package:multibook/src/domain/use_cases/payment_methods/set_default_payment_method_use_case.dart';
import 'package:multibook/src/features/customer-side/payment_methods/cubit/payment_methods_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  PaymentMethodsCubit(
    this._getPaymentMethods,
    this._savePaymentMethod,
    this._deletePaymentMethod,
    this._setDefaultPaymentMethod,
  ) : super(const PaymentMethodsState());

  final GetPaymentMethodsUseCase _getPaymentMethods;
  final SavePaymentMethodUseCase _savePaymentMethod;
  final DeletePaymentMethodUseCase _deletePaymentMethod;
  final SetDefaultPaymentMethodUseCase _setDefaultPaymentMethod;

  Future<void> load() async {
    final result = await _getPaymentMethods.execute();
    if (isClosed) return;
    switch (result) {
      case Success(value: final methods):
        emit(PaymentMethodsState(loading: false, methods: methods));
      case FailureResult():
        emit(const PaymentMethodsState(loading: false));
    }
  }

  Future<void> delete(String id) async {
    await _deletePaymentMethod.execute(id);
    await load();
  }

  Future<void> setDefault(String id) async {
    await _setDefaultPaymentMethod.execute(id);
    await load();
  }

  Future<bool> save({
    required String number,
    required String expiry,
    required String holder,
  }) async {
    final result = await _savePaymentMethod.execute(
      cardNumber: number,
      expiry: expiry,
      holderName: holder,
    );
    return result is Success;
  }
}
