class Doctor{

  Doctor(
      {
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.dni,
        required this.genre,
        required this.birthday,
        required this.range,
        required this.speciality
      }
      );

  int id;
  String firstName;
  String lastName;
  int dni;
  String genre;
  String birthday;
  String range;
  String speciality;

  String getAllName(){
    return '$firstName $lastName';
  }

  String getSpeciality(){
    return speciality;
  }

}