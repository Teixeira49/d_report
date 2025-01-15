class PatientGuardianEditRequest {
  PatientGuardianEditRequest({
    required this.patGuId,
    required this.patGuDni,
    required this.patGuAddress,
    required this.patGuTlf,
    required this.patGuEmail,
  });

  int patGuId;
  int patGuDni;
  String? patGuAddress;
  String patGuTlf;
  String? patGuEmail;
}
