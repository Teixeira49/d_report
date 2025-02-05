

import 'package:flutter/services.dart';

class DecimalTextInputFormatter extends TextInputFormatter {
  final RegExp _regExp = RegExp(r'^\d*\.?\d*$');

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (_regExp.hasMatch(newValue.text)) {
      if (newValue.text.split('.').length - 1 <= 1) {
        return newValue;
      }
    }
    return oldValue;
  }
}