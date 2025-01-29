class AccountProfileRequest{

  AccountProfileRequest(
      {
        required this.firstName,
        required this.lastName,
        required this.genre,
        required this.email,
        required this.phone,
        required this.range,
        required this.password,
      }
    );

  String firstName;
  String lastName;
  String genre;
  String email;
  String phone;
  String range;
  String password;
}