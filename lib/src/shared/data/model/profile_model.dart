import '../../domain/entities/doctor.dart';

class DoctorProfileModel extends DoctorProfile {
  DoctorProfileModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.dni,
    required super.genre,
    required super.birthday,
    required super.range,
    required super.speciality,
    required super.photoUrl,
    required super.email,
    required super.phone,
  });

  factory DoctorProfileModel.fromJson(json) {
    return DoctorProfileModel(
      id: json['docId'],
      firstName: json['docFirstName'],
      lastName: json['docLastName'],
      dni: json['docDni'],
      genre: json['docGender'],
      birthday: json['docBirthday'],
      range: json['rolId'],
      speciality: json['docSpecialty'],
      photoUrl: json['docPhotoUrl'] ?? '',
      email: json['userEmail'],
      phone: json['userPhone'],
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
      'rolId': range,
      'docSpecialty': speciality,
      'photoUrl': photoUrl,
      'userEmail': email,
      'userPhone': phone,
    };
  }

  factory DoctorProfileModel.fromEntity(DoctorProfile doctor) {
    return DoctorProfileModel(
      id: doctor.id,
      firstName: doctor.firstName,
      lastName: doctor.lastName,
      dni: doctor.dni,
      genre: doctor.genre,
      birthday: doctor.birthday,
      range: doctor.range,
      speciality: doctor.speciality,
      photoUrl: doctor.photoUrl,
      email: doctor.email,
      phone: doctor.phone,
    );
  }
}
