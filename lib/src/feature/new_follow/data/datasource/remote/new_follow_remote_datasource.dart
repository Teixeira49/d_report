import 'package:d_report/src/core/utils/constants/network_constants.dart';
import 'package:dio/dio.dart';
import 'package:retry/retry.dart';

import '../../../domain/entities/follow_case.dart';
import '../../models/follow_case_model.dart';



abstract class FollowCaseRemoteDataSource {
  Future<FollowCase> postCaseFollowsByCase(Map<String, dynamic> data, String accessToken);
}


class FollowCaseDataSourceImpl implements FollowCaseRemoteDataSource{

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  final Dio dio = Dio();

  @override
  Future<FollowCase> postCaseFollowsByCase(Map<String, dynamic> data, String accessToken) async {

    if(!_isFetching) {
      _isFetching = true;
    }

    const r = RetryOptions(maxAttempts: 3);

    print('ENTRADA ${FollowModel.fromBodyJson(data).toJson()}');

    final resp = await r.retry(() => dio.post(
      '$apiUrl/cases/operations/follows/add',
      options: Options(
        sendTimeout: const Duration(seconds: 3),
        receiveTimeout: const Duration(seconds: 3),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
      data: FollowModel.fromBodyJson(data).toJson()
    ));

    print('SALIDA ${resp.data}');

    return FollowModel.fromJson(resp.data);
  }
}