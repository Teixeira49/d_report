import 'package:d_report/src/feature/auth/domain/repository/auth_user_repository.dart';
import 'package:d_report/src/shared/domain/entities/user.dart';

import '../../../../core/network/error/exceptions.dart';
import '../../../../core/network/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../shared/domain/entities/auth_user.dart';
import '../datasource/remote/auth_user_remote_datasource.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthUserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<AuthUser> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final userModel = await remoteDataSource.login(email, password);
        return AuthUser(
            accessToken: userModel.accessToken,
            refreshToken: userModel.refreshToken,
            roleId: userModel.roleId,
            userEnabled: userModel.userEnabled);
      } on ServerException catch (e) {
        throw ServerFailure(e.message);
      }
    } else {
      throw ServerFailure("No Internet connection");
    }
  }

  @override
  Future<User> getProfile(String email, String accessToken) async {
    if (await networkInfo.isConnected) {
      try {
        final userModel = await remoteDataSource.getProfile(email, accessToken);
        print(userModel.userProfileId);
        return User(
            userName: userModel.userName,
            userEmail: userModel.userEmail,
            userRoleUid: userModel.userRoleUid,
            userImgUrl: userModel.userImgUrl,
            userProfileId: userModel.userProfileId);
      } on ServerException catch (e) {
        throw ServerFailure(e.message);
      }
    } else {
      throw ServerFailure("No Internet connection");
    }
  }
}
