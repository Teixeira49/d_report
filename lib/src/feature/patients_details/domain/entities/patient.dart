
class Patient{

  Patient(
    {
      required this.patId,
      required this.patName,
      required this.patLastname,
      required this.patDni,
      required this.patGender,
      required this.patBirthdayDate,
      required this.patBirthdayPlace,
      required this.patGuardianDni,
      required this.patBloodType,

    }
  );

  int patId;
  String patName;
  String patLastname;
  int? patDni;
  String patGender;
  String patBirthdayDate;
  String? patBirthdayPlace;
  int patGuardianDni;
  String patBloodType;
}