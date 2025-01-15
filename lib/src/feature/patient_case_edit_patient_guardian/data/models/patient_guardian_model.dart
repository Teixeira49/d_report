import '../../domain/entities/patient_guardian.dart';

class PatientGuardianModel extends PatientGuardian {
  PatientGuardianModel({
    required super.patGuId,
    required super.patGuDni,
    required super.patGuAddress,
    required super.patGuTlf,
    required super.patGuEmail,
  });

  factory PatientGuardianModel.fromJson(json) {
    return PatientGuardianModel(
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

  factory PatientGuardianModel.fromEntity(PatientGuardian patientGuardian) {
    return PatientGuardianModel(
      patGuId: patientGuardian.patGuId,
      patGuDni: patientGuardian.patGuDni,
      patGuAddress: patientGuardian.patGuAddress,
      patGuTlf: patientGuardian.patGuTlf,
      patGuEmail: patientGuardian.patGuEmail,
    );
  }
}
