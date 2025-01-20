import '../../../../core/utils/constants/fields_constants.dart';
import '../../domain/entities/doctor.dart';

class DoctorModel extends Doctor {
  DoctorModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.dni,
    required super.genre,
    required super.birthday,
    required super.range,
    required super.speciality,
  });

  factory DoctorModel.fromJson(json) {
    return DoctorModel(
      id: json['docId'],
      firstName: json['docFirstName'],
      lastName: json['docLastName'],
      dni: json['docDni'],
      genre: json['docGender'],
      birthday: json['docBirthday'],
      range: "DOCTOR", //json['docIsAdmin'],
      speciality: json['docSpecialty'],
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
    };
  }

  factory DoctorModel.fromEntity(Doctor doctor) {
    return DoctorModel(
      id: doctor.id,
      firstName: doctor.firstName,
      lastName: doctor.lastName,
      dni: doctor.dni,
      genre: doctor.genre,
      birthday: doctor.birthday,
      range: "DOCTOR", //doctor.range
      speciality: doctor.speciality,
    );
  }
}
