
class AuthUser {
  AuthUser({
    required this.accessToken,
    required this.refreshToken,
    required this.roleId,
    required this.userEnabled,
  });

  String accessToken;
  String refreshToken;
  int roleId;
  bool userEnabled;
}
