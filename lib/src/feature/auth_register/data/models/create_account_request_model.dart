import '../../domain/entities/create_account_request.dart';

class AccountProfileRequestModel extends AccountProfileRequest {
  AccountProfileRequestModel({
    required super.firstName,
    required super.lastName,
    required super.genre,
    required super.email,
    required super.phone,
    required super.range,
    required super.password,
  });

  factory AccountProfileRequestModel.fromJson(json) {
    return AccountProfileRequestModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      genre: json['genre'],
      email: json['email'],
      phone: json['phone'],
      range: json['range'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'docFirstName': firstName,
      'docLastName': lastName,
      'docGender': genre,
      'userEmail': email,
      'userPhone': phone,
      'rolId': range,
      'password': password,
    };
  }

  factory AccountProfileRequestModel.fromEntity(AccountProfileRequest doctor) {
    return AccountProfileRequestModel(
      firstName: doctor.firstName,
      lastName: doctor.lastName,
      genre: doctor.genre,
      range: doctor.range,
      email: doctor.email,
      phone: doctor.phone,
      password: doctor.password,
    );
  }
}
