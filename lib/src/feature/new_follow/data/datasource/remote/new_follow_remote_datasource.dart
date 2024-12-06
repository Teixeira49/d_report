import 'package:dio/dio.dart';
import 'package:retry/retry.dart';

import '../../../domain/entities/follow_case.dart';



abstract class FollowCaseRemoteDataSource {
  Future<FollowCase> postCaseFollowsByCase(int cafId, String accessToken);
}


class FollowCaseDataSourceImpl implements FollowCaseRemoteDataSource{

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  final Dio dio = Dio();

  @override
  Future<FollowCase> postCaseFollowsByCase(int cafId, String accessToken) async {

    if(!_isFetching) {
      _isFetching = true;
    }

    const r = RetryOptions(maxAttempts: 3);


    final resp = await r.retry(() => dio.post(
      'http://192.168.30.196:9004/api/cases/operations/follows/add', // TODO Create a Global with route
      options: Options(
        sendTimeout: const Duration(seconds: 3),
        receiveTimeout: const Duration(seconds: 3),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
      data: {

      }
    ));

    print('KONO DIO DAA');
    print(resp.data);


    return FollowDetailedModel.fromJson(resp.data);
  }

  Future<void> refreshGetCaseFollowsByCase(cafId, accessToken) async {
    //emit(MyCasesInitial());
    await postCaseFollowsByCase(cafId, accessToken);
  }
}