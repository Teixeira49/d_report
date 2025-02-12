import '../../domain/entities/patient_edit_request.dart';

class PatientEditRequestModel extends PatientEditRequest {
  PatientEditRequestModel({
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
        patId: json['patId'],
        patFirstName: json['patName'],
        patSecondName: json['patSecName'],
        patLastname: json['patLastName'],
        patSecondSurname: json['patSecSurName'],
        patBirthdayDate: json['patBirthdayDate'],
        patBirthdayPlace: json['patBirthdayPlace'],
        patBloodType: json['patBloodType'],
        patDni: json['patDni'],
        patGender: json['patGender'],
        patGuardianDni: json['patGuardianDni'],
        patWeight: 4500,// json['patWeight'],
        patHeight: 15//json['patHeight']
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
      //'patWeight': patWeight,
      //'patHeight': patHeight,
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
          'patBirthdayDate': patBirthdayDate,
          'patBirthdayPlace': patBirthdayPlace,
          'patDni': patDni,
          'patGender': patGender,
          'patBloodType': patBloodType,
          //'patWeight': patWeight,
          //'patHeight': patHeight,
        };
      default:
        return toJson();
    }
  }

  factory PatientEditRequestModel.fromEntity(
      PatientEditRequest patientEditRequest) {
    return PatientEditRequestModel(
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
