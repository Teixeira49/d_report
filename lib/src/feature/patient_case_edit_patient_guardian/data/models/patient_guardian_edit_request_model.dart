import '../../domain/entities/patient_guardian_edit_request.dart';

class PatientGuardianEditRequestModel extends PatientGuardianEditRequest {
  PatientGuardianEditRequestModel({
    required super.patId,
    required super.patGuardianDni,
    required super.patGuardianAddress,
    required super.patGuardianPhone,
    required super.patGuardianEmail,
  });

  factory PatientGuardianEditRequestModel.fromJson(json) {
    return PatientGuardianEditRequestModel(
      patId: json['patId'],
      patGuardianDni: json['patGuardianDni'],
      patGuardianAddress: json['patGuardianAddress'],
      patGuardianPhone: json['patGuardianPhone'],
      patGuardianEmail: json['patGuardianEmail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patId': patId,
      'patGuardianDni': patGuardianDni,
      'patGuardianAddress': patGuardianAddress,
      'patGuardianPhone': patGuardianPhone,
      'patGuardianEmail': patGuardianEmail,
    };
  }

  factory PatientGuardianEditRequestModel.fromEntity(
      PatientGuardianEditRequest patientGuardianEditRequest) {
    return PatientGuardianEditRequestModel(
      patId: patientGuardianEditRequest.patId,
      patGuardianDni: patientGuardianEditRequest.patGuardianDni,
      patGuardianAddress: patientGuardianEditRequest.patGuardianAddress,
      patGuardianPhone: patientGuardianEditRequest.patGuardianPhone,
      patGuardianEmail: patientGuardianEditRequest.patGuardianEmail,
    );
  }
}
