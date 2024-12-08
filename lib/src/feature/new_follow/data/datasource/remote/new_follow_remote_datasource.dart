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

    print('AAA');
    print(FollowModel.fromBodyJson(data).toJson());

    final resp = await r.retry(() => dio.post(
      'http://192.168.30.196:9004/api/cases/operations/follows/add', // TODO Create a Global with route
      options: Options(
        sendTimeout: const Duration(seconds: 3),
        receiveTimeout: const Duration(seconds: 3),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
      data: FollowModel.fromBodyJson(data).toJson()
    ));

    print('KONO DIO DAA');
    print(resp.data);


    return FollowModel.fromJson(resp.data);
  }
}