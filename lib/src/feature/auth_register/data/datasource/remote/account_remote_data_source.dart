
import 'package:dio/dio.dart';
import 'package:retry/retry.dart';

import '../../../../../core/utils/constants/network_constants.dart';
import '../../../domain/entities/create_account_request.dart';
import '../../models/create_account_request_model.dart';

abstract class RegisterAccountRemoteDataSource {

  Future<AccountProfileRequest> registerAccount(
      AccountProfileRequest profileRequest);

  Future<String> validateEmail(String email);
}

class RegisterAccountRemoteDataSourceImpl implements RegisterAccountRemoteDataSource {

  final Dio dio = Dio();

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  @override
  Future<AccountProfileRequest> registerAccount(AccountProfileRequest profileRequest) async {
    if (!_isFetching) {
      _isFetching = true;
    }

    const r = RetryOptions(maxAttempts: 3);


    final resp = await r.retry(() => dio.post('$apiUrl/login/doctor/registration',
        options: Options(
          sendTimeout: const Duration(seconds: 2),
          receiveTimeout: const Duration(seconds: 2),
        ),
        data: AccountProfileRequestModel.fromEntity(profileRequest).toJson()));

    print(resp.data);

    return AccountProfileRequestModel.fromJson(resp.data);
  }

  @override
  Future<String> validateEmail(String email) async {
    if (!_isFetching) {
      _isFetching = true;
    }

    const r = RetryOptions(maxAttempts: 3);


    final resp = await r.retry(() => dio.get('$apiUrl/login/validate/email/$email',
        options: Options(
          sendTimeout: const Duration(seconds: 2),
          receiveTimeout: const Duration(seconds: 2),
        ),
    ));

    return resp.data;
  }

}