class Patient {

  final String patName;
  final String patLastName;
  final int? patDni;
  final String patGender;
  final String patBirthdayDate;
  final String? patBirthdayPlace;
  final int patGuardianDni;
  final String patBloodType;

  Patient(
      {
        required  this .patName,
        required  this .patLastName,
        required  this .patDni,
        required  this .patGender,
        required  this .patBirthdayDate,
        required  this .patBirthdayPlace,
        required  this .patGuardianDni,
        required  this .patBloodType,
      }
      );
}