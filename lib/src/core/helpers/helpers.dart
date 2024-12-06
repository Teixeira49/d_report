
class Helper {

  static String getDateSMSByString(String dateTargetString) {
    DateTime parsedDate = DateTime.parse(dateTargetString);
    List<String> parsedDataList = parsedDate.toLocal().toIso8601String().split('T');
    return "El ${parsedDataList[0]} a las ${parsedDataList[1].split(".")[0]} horas";
  }

  static String getFullNameInRow(String name, String lastName) {
    return '$name $lastName';
  }
}