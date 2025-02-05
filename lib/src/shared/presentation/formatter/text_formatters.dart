import 'package:flutter/services.dart';

class TextFormatters {
  static final List<TextInputFormatter> onlyLettersAndNumbers = [
    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ]'))
  ];

  static final List<TextInputFormatter> onlyNumbersForMetrics = [
    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
  ];

  static final TextInputFormatter onlyNumbers =
      FilteringTextInputFormatter.digitsOnly;

  static final FilteringTextInputFormatter allowNegativeNumbers =
      FilteringTextInputFormatter.allow(RegExp(r'^-?[0-9]'));

  static final List<TextInputFormatter> dniFormatter = [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(9),
  ];

  static final List<TextInputFormatter> floorFormatter = [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(3),
  ];
}
