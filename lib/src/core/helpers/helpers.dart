import 'package:intl/intl.dart';

import '../utils/constants/fields_constants.dart';

class Helper {
  static String getCodeByDate() {
    return '${DateTime.now()}'
        .replaceAll(':', emptyString)
        .replaceAll('.', emptyString)
        .replaceAll('-', emptyString)
        .replaceAll(' ', '-');
  }

  static String getDateSMSByString(String dateTargetString,
      [bool isRev = false]) {
    DateTime parsedDate = DateTime.parse(dateTargetString);
    List<String> parsedDataList =
        parsedDate.toLocal().toIso8601String().split('T');
    if (isRev) {
      DateFormat date = DateFormat("dd/MM/yyyy");
      parsedDataList[0] = date.format(DateTime.parse(parsedDataList[0]));
    }
    return "El ${parsedDataList[0]} a las ${parsedDataList[1].split(".")[0]} horas";
  }

  static String getDateWithoutHour(DateTime dateTime) {
    return '${addZero(dateTime.day)}/${addZero(dateTime.month)}/${dateTime.year}';
  }

  static String cutDateByString(String dateTarget) {
    dateTarget = dateTarget.substring(3, 13);
    DateTime parsedDate = DateTime.parse(dateTarget);
    DateFormat date = DateFormat("dd/MM/yyyy");
    return date.format(parsedDate);
  }

  static String addZero(int date,
      [bool isNegative = false, int margin = 10, int frequency = 1]) {
    if (date < margin && date >= 0) {
      return '${'0' * frequency}$date';
    } else if (date < 0 && date > margin * -1) {
      return '-${isNegative ? '0' * frequency : emptyString}${date.toString().substring(1)}';
    }
    return date.toString();
  }

  static String fillZero(String data, [int maxFill = 3]) {
    return '${'0' * (3 - data.length)}$data';
  }

  static String getFullNameInRow(String name, String lastName) {
    return '$name $lastName';
  }

  static String capitalize(String text, [bool lower = true]) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() +
        (lower ? text.substring(1).toLowerCase() : text.substring(1));
  }

  static int getAgeByDateInString(String dateTargetString) {
    var temp = dateTargetString.split('T')[0];
    DateFormat time = DateFormat("yyyy-MM-dd");
    DateTime birthdayTemp = time.parse(temp);
    DateTime nowTemp = DateTime.now();

    var age = nowTemp.year - birthdayTemp.year;
    if (nowTemp.year - birthdayTemp.year <= 0 &&
        (nowTemp.month - birthdayTemp.month == 0 &&
            nowTemp.day - birthdayTemp.day < 0)) {
      age--;
    }
    return age;
  }

  static int countCaseDaysByString(String dateTarget, [String? endTarget]) {
    DateTime iTarget = DateTime.parse(dateTarget);
    DateTime fTarget =
        endTarget == null ? DateTime.now() : DateTime.parse(endTarget);
    return fTarget.difference(iTarget).inDays;
  }

  static String writeHeightByInt(int originHeight, [bool reverse = false]) {
    final fixedHeight = reverse ? (originHeight * 100) : (originHeight / 100);
    return fixedHeight.toStringAsFixed(2);
  }

  static String writeWeightByInt(int originWeight, [bool reverse = false]) {
    final fixedWeight = reverse ? (originWeight * 1000) : (originWeight / 1000);
    return fixedWeight.toStringAsFixed(2);
  }

  static String writeHeightByDouble(double originHeight,
      [bool reverse = false]) {
    final fixedHeight = reverse ? (originHeight * 100) : (originHeight / 100);
    return fixedHeight.round().toStringAsFixed(0);
  }

  static String writeWeightByDouble(double originWeight,
      [bool reverse = false]) {
    final fixedWeight = reverse ? (originWeight * 1000) : (originWeight / 1000);
    return fixedWeight.round().toStringAsFixed(0);
  }
}
