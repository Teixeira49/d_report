import '../../domain/entities/patient_guardian.dart';

class PatientGuardianModel extends PatientGuardian {
  PatientGuardianModel({
    required super.patId,
    required super.patGuardianDni,
    required super.patGuardianAddress,
    required super.patGuardianPhone,
    required super.patGuardianEmail,
  });

  factory PatientGuardianModel.fromJson(json) {
    return PatientGuardianModel(
      patId: json['patId'],
      patGuardianDni: json['patGuardianDni'],
      patGuardianAddress: json['patGuardianAddress'],
      patGuardianPhone: json['patGuardianPhone'],
      patGuardianEmail: json['patGuardianEmail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patGuardianId': patId,
      'patGuardianDni': patGuardianDni,
      'patGuardianAddress': patGuardianAddress,
      'patGuardianPhone': patGuardianPhone,
      'patGuardianEmail': patGuardianEmail,
    };
  }

  factory PatientGuardianModel.fromEntity(PatientGuardian patientGuardian) {
    return PatientGuardianModel(
      patId: patientGuardian.patId,
      patGuardianDni: patientGuardian.patGuardianDni,
      patGuardianAddress: patientGuardian.patGuardianAddress,
      patGuardianPhone: patientGuardian.patGuardianPhone,
      patGuardianEmail: patientGuardian.patGuardianEmail,
    );
  }
}
