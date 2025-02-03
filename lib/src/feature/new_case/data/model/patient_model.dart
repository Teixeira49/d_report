import '../../domain/entities/patient.dart';

class PatientModel extends Patient {
  PatientModel({
    required super.patName,
    required super.patLastName,
    required super.patDni,
    required super.patGender,
    required super.patBirthdayDate,
    required super.patBirthdayPlace,
    required super.patGuardianDni,
    required super.patBloodType,
    required super.patGuardianEmail,
    required super.patGuardianPhone,
  });

  factory PatientModel.fromJson(json) {
    return PatientModel(
      patName: json['patName'],
      patLastName: json['patLastName'],
      patDni: json['patDni'],
      patGender: json['patGender'],
      patBirthdayDate: json['patBirthdayDate'],
      patBirthdayPlace: json['patBirthdayPlace'],
      patGuardianDni: json['patGuardianDni'],
      patBloodType: json['patBloodType'],
      patGuardianEmail: json['patGuEmail'] != "" ? json['patGuEmail'] : null,
      patGuardianPhone: json['patGuPhone'] != "" ? json['patGuPhone'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patName': patName,
      'patLastName': patLastName,
      'patDni': patDni,
      'patGender': patGender,
      'patBirthdayDate': patBirthdayDate,
      'patBirthdayPlace': patBirthdayPlace,
      'patGuardianDni': patGuardianDni,
      'patBloodType': patBloodType,
      'patGuardianEmail': patGuardianEmail,
      'patGuardianPhone': patGuardianPhone
    };
  }

  factory PatientModel.fromEntity(Patient patient) {
    return PatientModel(
      patName: patient.patName,
      patLastName: patient.patLastName,
      patDni: patient.patDni,
      patGender: patient.patGender,
      patBirthdayDate: patient.patBirthdayDate,
      patBirthdayPlace: patient.patBirthdayPlace,
      patGuardianDni: patient.patGuardianDni,
      patBloodType: patient.patBloodType,
      patGuardianEmail: patient.patGuardianEmail,
      patGuardianPhone: patient.patGuardianPhone,
    );
  }
}
