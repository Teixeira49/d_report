import '../../domain/entities/patient_guardian_edit_request.dart';

class PatientGuardianEditRequestModel extends PatientGuardianEditRequest {
  PatientGuardianEditRequestModel({
    required super.patGuId,
    required super.patGuDni,
    required super.patGuAddress,
    required super.patGuTlf,
    required super.patGuEmail,
  });

  factory PatientGuardianEditRequestModel.fromJson(json) {
    return PatientGuardianEditRequestModel(
      patGuId: json['patGuId'],
      patGuDni: json['patGuDni'],
      patGuAddress: json['patGuAddress'],
      patGuTlf: json['patGuTlf'],
      patGuEmail: json['patGuEmail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patGuId': patGuId,
      'patGuDni': patGuDni,
      'patGuAddress': patGuAddress,
      'patGuTlf': patGuTlf,
      'patGuEmail': patGuEmail,
    };
  }

  factory PatientGuardianEditRequestModel.fromEntity(
      PatientGuardianEditRequest patientGuardianEditRequest) {
    return PatientGuardianEditRequestModel(
      patGuId: patientGuardianEditRequest.patGuId,
      patGuDni: patientGuardianEditRequest.patGuDni,
      patGuAddress: patientGuardianEditRequest.patGuAddress,
      patGuTlf: patientGuardianEditRequest.patGuTlf,
      patGuEmail: patientGuardianEditRequest.patGuEmail,
    );
  }
}
