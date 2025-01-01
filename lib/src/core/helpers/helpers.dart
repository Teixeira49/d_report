import 'package:intl/intl.dart';

class Helper {

  static String getDateSMSByString(String dateTargetString) {
    DateTime parsedDate = DateTime.parse(dateTargetString);
    List<String> parsedDataList = parsedDate.toLocal().toIso8601String().split('T');
    return "El ${parsedDataList[0]} a las ${parsedDataList[1].split(".")[0]} horas";
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
}