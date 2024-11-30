class Doctor{

  Doctor(
      {
        required this.id,
        required this.firstName,
        required this.secName,
        required this.lastName,
        required this.secLastName,
        required this.genre,
        required this.birthday,
        required this.range,
        required this.speciality
      }
      );

  int id;
  String firstName;
  String secName;
  String lastName;
  String secLastName;
  String genre;
  DateTime birthday;
  String range;
  String speciality;

  String getAllName(){
    return '$firstName $lastName';
  }

  String getSpeciality(){
    return speciality;
  }

}