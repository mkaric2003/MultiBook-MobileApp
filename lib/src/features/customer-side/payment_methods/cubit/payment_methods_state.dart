import 'package:multibook/src/features/customer-side/payment_methods/domain/models/saved_payment_method_model.dart';

class PaymentMethodsState {
  const PaymentMethodsState({this.loading = true, this.methods = const []});
  final bool loading;
  final List<SavedPaymentMethodModel> methods;
}
