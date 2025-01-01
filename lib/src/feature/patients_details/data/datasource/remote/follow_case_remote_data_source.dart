import 'package:d_report/src/core/utils/constants/network_constants.dart';
import 'package:d_report/src/feature/patients_details/data/models/follow_model.dart';
import 'package:d_report/src/feature/patients_details/domain/entities/follows_in_case.dart';
import 'package:dio/dio.dart';
import 'package:retry/retry.dart';

abstract class FollowCaseRemoteDataSource {
  Future<List<FollowCase>> getCaseFollowsByCase(int casId, String accessToken);
}

class FollowCaseRemoteDataSourceImpl implements FollowCaseRemoteDataSource {
  int _page = 1;
  bool _isFetching = false;

  bool get isFetching => _isFetching;

  final Dio dio = Dio();

  @override
  Future<List<FollowCase>> getCaseFollowsByCase(
      int casId, String accessToken) async {
    if (!_isFetching) {
      _isFetching = true;
    }

    const r = RetryOptions(maxAttempts: 3);

    final resp = await r.retry(() =>
        dio.get('$apiUrl/cases/follows/view-follow',
            options: Options(
              sendTimeout: const Duration(seconds: 3),
              receiveTimeout: const Duration(seconds: 3),
              headers: {
                'Authorization': 'Bearer $accessToken',
              },
            ),
            queryParameters: {
              "id": casId,
              "pag": _page,
              //"size"
              //'isRev'
            }));

    print(casId);
    print(resp.data["content"]);

    _page++;

    final List<FollowCase> items = (resp.data["content"] as List)
        .map((item) => FollowModel.fromJson(item))
        .toList();

    print('Mis items $items');
    return items;
  }

  Future<void> refreshFollowCases(casId, accessToken) async {
    _page = 1;
    await getCaseFollowsByCase(casId, accessToken);
  }
}
