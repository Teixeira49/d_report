class PatientGuardian{

  PatientGuardian(
      {
        required this.patId,
        required this.patGuardianDni,
        required this.patGuardianAddress,
        required this.patGuardianPhone,
        required this.patGuardianEmail,
      }
      );

  int patId;
  int patGuardianDni;
  String? patGuardianAddress;
  String? patGuardianPhone;
  String? patGuardianEmail;
}