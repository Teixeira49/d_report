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
      patName: json['patId']['patName'],
      patLastname: json['patId']['patLastName'],
      patId: json['patId']['patId'],
      patBirthdayDate: json['patId']['patBirthdayDate'],
      patBirthdayPlace: json['patId']['patBirthdayPlace'],
      patBloodType: json['patId']['patBloodType'],
      patDni: json['patId']['patDni'],
      patGender: json['patId']['patGender'],
      patGuardianDni: json['patId']['patGuardianDni']
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