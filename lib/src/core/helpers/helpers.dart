import 'package:intl/intl.dart';

class Helper {

  static String getCodeByDate() {
    return '${DateTime.now()}'.replaceAll(':', '').replaceAll('.', '').replaceAll('-', '').replaceAll(' ', '-');
  }

  static String getDateSMSByString(String dateTargetString, [bool isRev = false]) {
    DateTime parsedDate = DateTime.parse(dateTargetString);
    List<String> parsedDataList = parsedDate.toLocal().toIso8601String().split('T');
    if (isRev) {
      DateFormat date = DateFormat("dd/MM/yyyy");
      parsedDataList[0] = date.format(DateTime.parse(parsedDataList[0]));
    }
    return "El ${parsedDataList[0]} a las ${parsedDataList[1].split(".")[0]} horas";
  }

  static String getDateWithoutHour(DateTime dateTime){
    return '${addZero(dateTime.day)}/${addZero(dateTime.month)}/${dateTime.year}';
  }

  static String cutDateByString(String dateTarget) {
    dateTarget = dateTarget.substring(3,13);
    DateTime parsedDate = DateTime.parse(dateTarget);
    DateFormat date = DateFormat("dd/MM/yyyy");
    return date.format(parsedDate);
  }

  static String addZero(int date) {
    return date < 10 ? '0$date' : '$date';
  }

  static String getFullNameInRow(String name, String lastName) {
    return '$name $lastName';
  }

  static String capitalize(String text){
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
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

  static String writeHeightByInt(int originHeight, [bool reverse = false]) {
    final fixedHeight = reverse ? (originHeight * 100) : (originHeight / 100);
    return fixedHeight.toStringAsFixed(2);
  }

  static String writeWeightByInt(int originWeight, [bool reverse = false]) {
    final fixedWeight = reverse ? (originWeight * 1000) : (originWeight / 1000);
    return fixedWeight.toStringAsFixed(2);
  }

  static String writeHeightByDouble(double originHeight, [bool reverse = false]) {
    final fixedHeight = reverse ? (originHeight * 100) : (originHeight / 100);
    return fixedHeight.round().toStringAsFixed(0);
  }

  static String writeWeightByDouble(double originWeight, [bool reverse = false]) {
    final fixedWeight = reverse ? (originWeight * 1000) : (originWeight / 1000);
    return fixedWeight.round().toStringAsFixed(0);
  }
}