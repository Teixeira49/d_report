import '../../domain/entities/patient.dart';

class PatientModel extends SearchPatient {
  PatientModel({
    required super.patName,
    required super.patLastName,
    required super.patDni,
    required super.patGender,
    required super.patBirthdayDate,
    required super.patBirthdayPlace,
    required super.patGuardianDni,
    required super.patBloodType,
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
    };
  }

  factory PatientModel.fromEntity(SearchPatient patient) {
    return PatientModel(
      patName: patient.patName,
      patLastName: patient.patLastName,
      patDni: patient.patDni,
      patGender: patient.patGender,
      patBirthdayDate: patient.patBirthdayDate,
      patBirthdayPlace: patient.patBirthdayPlace,
      patGuardianDni: patient.patGuardianDni,
      patBloodType: patient.patBloodType,
    );
  }
}
