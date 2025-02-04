import '../../domain/entities/patient_edit_request.dart';

class PatientEditRequestModel extends PatientEditRequest {
  PatientEditRequestModel({
    required super.casId,
    required super.patId,
    required super.patFirstName,
    required super.patSecondName,
    required super.patLastname,
    required super.patSecondSurname,
    required super.patDni,
    required super.patBirthdayDate,
    required super.patGender,
    required super.patBirthdayPlace,
    required super.patBloodType,
    required super.patGuardianDni,
    required super.patWeight,
    required super.patHeight,
  });

  factory PatientEditRequestModel.fromJson(json) {
    return PatientEditRequestModel(
      casId: json['casId'],
        patId: json['patId'],
        patFirstName: json['patFirstName'],
        patSecondName: json['patSecondName'],
        patLastname: json['patLastname'],
        patSecondSurname: json['patSecondSurname'],
        patBirthdayDate: json['patBirthdayDate'],
        patBirthdayPlace: json['patBirthdayPlace'],
        patBloodType: json['patBloodType'],
        patDni: json['patDni'],
        patGender: json['patGender'],
        patGuardianDni: json['patGuardianDni'],
        patWeight: json['patWeight'],
        patHeight: json['patHeight']
    );}

  Map<String, dynamic> toJson() {
    return {
      'patId': patId,
      'patFirstName': patFirstName,
      'patSecondName': patSecondName,
      'patLastname': patLastname,
      'patSecondSurname': patSecondSurname,
      'patBirthdayDate': patBirthdayDate,
      'patBirthdayPlace': patBirthdayPlace,
      'patBloodType': patBloodType,
      'patDni': patDni,
      'patGender': patGender,
      'patGuardianDni': patGuardianDni,
      'patWeight': patWeight,
      'patHeight': patHeight,
    };
  }

  Map<String, dynamic> toSubJson(int part) {
    switch (part) {
      case 0:
        return {
          "patId": patId,
          "patFirstName": patFirstName,
          'patSecondName': patSecondName,
          'patLastname': patLastname,
          'patSecondSurname': patSecondSurname, // TODO admin once
        };
      case 1:
        return {
          "patId": patId,
          'casId': casId,
          'patBirthdayDate': patBirthdayDate,
          'patBirthdayPlace': patBirthdayPlace,
          'patDni': patDni,
          'patGender': patGender,
          'patBloodType': patBloodType,
          'patWeight': patWeight,
          'patHeight': patHeight,
        };
      default:
        return toJson();
    }
  }

  factory PatientEditRequestModel.fromEntity(
      PatientEditRequest patientEditRequest) {
    return PatientEditRequestModel(
        casId: patientEditRequest.casId,
        patId: patientEditRequest.patId,
        patFirstName: patientEditRequest.patFirstName,
        patSecondName: patientEditRequest.patSecondName,
        patLastname: patientEditRequest.patLastname,
        patSecondSurname: patientEditRequest.patSecondSurname,
        patDni: patientEditRequest.patDni,
        patBirthdayDate: patientEditRequest.patBirthdayDate,
        patGender: patientEditRequest.patGender,
        patBirthdayPlace: patientEditRequest.patBirthdayPlace,
        patBloodType: patientEditRequest.patBloodType,
        patGuardianDni: patientEditRequest.patGuardianDni,
        patWeight: patientEditRequest.patWeight,
        patHeight: patientEditRequest.patHeight,);
  }
}
