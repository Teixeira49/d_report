
import 'package:dio/dio.dart';
import 'package:retry/retry.dart';

import '../../../domain/entities/follows_detailed_case.dart';
import '../../models/follow_detailed_model.dart';

abstract class FollowCaseDetailsRemoteDataSource {
  Future<FollowDetailedCase> getCaseFollowsByCase(int cafId, String accessToken);
}


class FollowCaseDetailsRemoteDataSourceImpl implements FollowCaseDetailsRemoteDataSource{

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  final Dio dio = Dio();

  @override
  Future<FollowDetailedCase> getCaseFollowsByCase(int cafId, String accessToken) async {

    if(!_isFetching) {
      _isFetching = true;
    }

    const r = RetryOptions(maxAttempts: 3);


    final resp = await r.retry(() => dio.get(
      'http://192.168.30.196:9004/api/cases/operations/follows/view/$cafId', // TODO Create a Global with route
      options: Options(
        sendTimeout: const Duration(seconds: 3),
        receiveTimeout: const Duration(seconds: 3),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    ));

    print('aaaaaaaaaa');
    print(resp.data);


    return FollowDetailedModel.fromJson(resp.data);
  }

  Future<void> refreshGetCaseFollowsByCase(cafId, accessToken) async {
    //emit(MyCasesInitial());
    await getCaseFollowsByCase(cafId, accessToken);
  }
}