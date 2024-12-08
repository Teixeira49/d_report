import 'package:dio/dio.dart';
import 'package:retry/retry.dart';

import '../../../../../shared/data/model/auth_user_model.dart';
import '../../../../../shared/data/model/user_model.dart';
import '../../../../../shared/domain/entities/auth_user.dart';
import '../../../../../shared/domain/entities/user.dart';

abstract class AuthUserRemoteDataSource {
  Future<AuthUser> login(String email, String password);

  Future<User> getProfile(String email, String accessToken);
}

class AuthUserRemoteDataSourceImpl implements AuthUserRemoteDataSource {
  final Dio dio = Dio();

  @override
  Future<AuthUser> login(String email, String password) async {
    const r = RetryOptions(maxAttempts: 3);

    final resp = await r.retry(
        () => dio.post('http://192.168.30.196:9004/api/auth/login/signin',
                // TODO Create a Global with route
                options: Options(
                  contentType: Headers.formUrlEncodedContentType,
                  sendTimeout: const Duration(seconds: 3),
                  receiveTimeout: const Duration(seconds: 3),
                ),
                data: {
                  'username': email,
                  'password': password,
                }));

    print('KONO DIO DAA');
    print(resp.data);

    return AuthUserModel.fromJson(resp.data);
  }

  @override
  Future<User> getProfile(String email, String accessToken) async {
    const r = RetryOptions(maxAttempts: 3);

    final resp = await r.retry(() => dio.get(
          'http://192.168.30.196:9004/api/doctors/doctor/find-by/email/$email/',
          // TODO Create a Global with route
          options: Options(
              sendTimeout: const Duration(seconds: 3),
              receiveTimeout: const Duration(seconds: 3),
              headers: {
                "Authorization": "Bearer $accessToken",
              }),
        ));

    print('KONO DIO DAA');
    resp.data['userEmail'] = email;
    print(resp.data);

    return UserModel.fromJson(resp.data);
  }
}