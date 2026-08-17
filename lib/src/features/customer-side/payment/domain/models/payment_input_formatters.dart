import 'package:flutter/services.dart';

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text
        .replaceAll(RegExp(r'\D'), '')
        .substring(
          0,
          newValue.text.replaceAll(RegExp(r'\D'), '').length.clamp(0, 16),
        );
    final groups = <String>[];
    for (var index = 0; index < digits.length; index += 4) {
      groups.add(digits.substring(index, (index + 4).clamp(0, digits.length)));
    }
    final text = groups.join(' ');
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class CardExpiryInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text
        .replaceAll(RegExp(r'\D'), '')
        .substring(
          0,
          newValue.text.replaceAll(RegExp(r'\D'), '').length.clamp(0, 4),
        );
    final text = digits.length > 2
        ? '${digits.substring(0, 2)}/${digits.substring(2)}'
        : digits;
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

abstract final class PaymentInputValidation {
  static final _cardNumber = RegExp(r'^\d{16}$');
  static final _expiry = RegExp(r'^(0[1-9]|1[0-2])\/?\d{2}$');
  static final _cvv = RegExp(r'^\d{3,4}$');

  static bool isCardNumberValid(String value) =>
      _cardNumber.hasMatch(value.replaceAll(RegExp(r'\s'), ''));

  static bool isExpiryValid(String value) =>
      _expiry.hasMatch(value.replaceAll(RegExp(r'\s'), ''));

  static bool isCvvValid(String value) => _cvv.hasMatch(value);
}
