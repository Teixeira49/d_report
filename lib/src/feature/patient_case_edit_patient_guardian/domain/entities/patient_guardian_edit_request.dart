class PatientGuardianEditRequest {
  PatientGuardianEditRequest({
    required this.patId, // TODO CHANGE TO patGuId when the table finishes
    required this.patGuardianDni,
    required this.patGuardianAddress,
    required this.patGuardianPhone,
    required this.patGuardianEmail,
  });

  int patId;
  int patGuardianDni;
  String? patGuardianAddress;
  String patGuardianPhone;
  String? patGuardianEmail;
}
