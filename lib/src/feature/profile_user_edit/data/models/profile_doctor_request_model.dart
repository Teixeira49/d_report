import '../../domain/entities/profile_doctor_request.dart';

class DoctorProfileRequestModel extends DoctorProfileRequest {
  DoctorProfileRequestModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.dni,
    required super.genre,
    required super.birthday,
    required super.range,
    required super.speciality,
    required super.phone
  });

  factory DoctorProfileRequestModel.fromJson(json) {
    return DoctorProfileRequestModel(
        id: json['docId'],
        firstName: json['docFirstName'],
        lastName: json['docLastName'],
        dni: json['docDni'],
        genre: json['docGender'],
        birthday: json['docBirthday'],
        range: "DOCTOR", //json['docIsAdmin'],
        speciality: json['docSpecialty'],
        phone: json['userPhone']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'docId': id,
      'docFirstName': firstName,
      'docLastName': lastName,
      'docDni': dni,
      'docGender': genre,
      'docBirthday': birthday,
      'docIsAdmin': range,
      'docSpecialty': speciality,
      'userPhone': phone,
    };
  }

  Map<String, dynamic> toRequestBody() {
    return {
      'uid': id,
      'docFirstName': firstName,
      'docLastName': lastName,
      'docDni': dni,
      'docGender': genre,
      'docBirthday': birthday,
      'docSpecialty': speciality,
      //'userPhone': phone,
    };
  }

  factory DoctorProfileRequestModel.fromEntity(DoctorProfileRequest doctor) {
    return DoctorProfileRequestModel(
        id: doctor.id,
        firstName: doctor.firstName,
        lastName: doctor.lastName,
        dni: doctor.dni,
        genre: doctor.genre,
        birthday: doctor.birthday,
        range: doctor.range,
        speciality: doctor.speciality,
        phone: doctor.phone
    );
  }
}
