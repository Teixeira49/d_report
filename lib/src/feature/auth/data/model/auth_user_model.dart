
import '../../domain/entities/auth_user.dart';

class AuthUserModel extends AuthUser {

  AuthUserModel({
    required  super .accessToken,
    required  super .refreshToken,
    required  super .roleId,
    required  super .userEnabled,
  });

  factory AuthUserModel.fromJson(json) {
    return AuthUserModel(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      roleId: json['user']['roleId'],
      userEnabled: json['user']['userIsEnabled'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'roleId': roleId,
      'userIsEnabled': userEnabled,
    };
  }

  factory AuthUserModel.fromEntity(AuthUser user) {
    return AuthUserModel(
      accessToken: user.accessToken,
      refreshToken: user.refreshToken,
      roleId: user.roleId,
      userEnabled: user.userEnabled,
    );
  }
}