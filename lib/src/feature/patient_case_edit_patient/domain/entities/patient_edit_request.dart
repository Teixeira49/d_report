class PatientEditRequest {
  PatientEditRequest({
    required this.casId,
    required this.patId,
    required this.patFirstName,
    required this.patSecondName,
    required this.patLastname,
    required this.patSecondSurname,
    required this.patDni,
    required this.patBirthdayDate,
    required this.patGender,
    required this.patBirthdayPlace,
    required this.patBloodType,
    required this.patGuardianDni,
    required this.patWeight,
    required this.patHeight,
  });

  int casId;
  int patId;
  String patFirstName;
  String? patSecondName;
  String patLastname;
  String? patSecondSurname;
  int? patDni;
  String patBirthdayDate;
  String patGender;
  String patBirthdayPlace;
  String patBloodType;
  int patGuardianDni;
  int? patWeight;
  int? patHeight;
}
