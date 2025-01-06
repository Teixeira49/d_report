import '../../../../core/helpers/helpers.dart';
import '../../domain/entities/patient.dart';

class PatientModel extends Patient {

  PatientModel({
    required  super .patId,
    required  super .patName,
    required  super .patLastname,
    required  super .patDni,
    required  super .patGender,
    required  super .patBirthdayDate,
    required  super .patBirthdayPlace,
    required  super .patGuardianDni,
    required  super .patBloodType,
  });

  factory PatientModel.fromJson(json) {
    return PatientModel(
      patName: Helper.capitalize(json['caseReport']['patId']['patName']),
      patLastname: Helper.capitalize(json['caseReport']['patId']['patLastName']),
      patId: json['caseReport']['patId']['patId'],
      patBirthdayDate: json['caseReport']['patId']['patBirthdayDate'],
      patBirthdayPlace: json['caseReport']['patId']['patBirthdayPlace'],
      patBloodType: json['caseReport']['patId']['patBloodType'],
      patDni: json['caseReport']['patId']['patDni'],
      patGender: json['caseReport']['patId']['patGender'],
      patGuardianDni: json['caseReport']['patId']['patGuardianDni']
    );
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
    );
  }
}