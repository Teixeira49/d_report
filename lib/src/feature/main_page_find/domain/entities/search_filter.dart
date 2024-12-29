
class SearchFilter {

  String gender = "Todos";
  String status = "Todos";
  String isEndCase = "Todos";

  void setParameters(String? newGender, String? newIsEndCase, String? newStatus) {
    gender = newGender ?? gender;
    isEndCase = newIsEndCase ?? isEndCase;
    status = newStatus ?? status;
  }
}