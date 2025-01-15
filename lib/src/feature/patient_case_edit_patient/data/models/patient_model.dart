import '../../../../core/helpers/helpers.dart';
import '../../domain/entities/patient.dart';

class PatientModel extends Patient {
  PatientModel({
    required super.patId,
    required super.patName,
    required super.patLastname,
    required super.patDni,
    required super.patGender,
    required super.patBirthdayDate,
    required super.patBirthdayPlace,
    required super.patGuardianDni,
    required super.patBloodType,
    required super.patWeight,
    required super.patHeight,
  });

  factory PatientModel.fromJson(json) {
    return PatientModel(
        patId: json['patId'],
        patName: json['patFirstName'],
        patLastname: json['patLastName'],
        patBirthdayDate: json['patBirthdayDate'],
        patBirthdayPlace: json['patBirthdayPlace'],
        patBloodType: json['patBloodType'],
        patDni: json['patDni'],
        patGender: json['patGender'],
        patGuardianDni: json['patGuardianDni'],
        patWeight: json['casKey']['patWeight'],
        patHeight: json['casKey']['patHeight']);
  }

  Map<String, dynamic> toJson() {
    return {
      'patId': patId,
      'patName': patName,
      'patLastname': patLastname,
      'patBirthdayDate': patBirthdayDate,
      'patBirthdayPlace': patBirthdayPlace,
      'patBloodType': patBloodType,
      'patDni': patDni,
      'patGender': patGender,
      'patGuardianDni': patGuardianDni,
    };
  }

  factory PatientModel.fromEntity(Patient patient) {
    return PatientModel(
      patId: patient.patId,
      patName: patient.patName,
      patLastname: patient.patLastname,
      patDni: patient.patDni,
      patGuardianDni: patient.patGuardianDni,
      patGender: patient.patGender,
      patBloodType: patient.patBloodType,
      patBirthdayPlace: patient.patBirthdayPlace,
      patBirthdayDate: patient.patBirthdayDate,
      patWeight: patient.patWeight,
      patHeight: patient.patHeight,
    );
  }
}
