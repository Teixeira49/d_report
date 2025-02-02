import 'package:d_report/src/core/utils/constants/network_constants.dart';
import 'package:d_report/src/feature/patients_details/data/models/follow_detailed_model.dart';
import 'package:d_report/src/feature/patients_details/data/models/follow_model.dart';
import 'package:d_report/src/feature/patients_details/data/models/follows_in_case_results_dto_model.dart';
import 'package:d_report/src/feature/patients_details/domain/entities/follows_detailed_case.dart';
import 'package:d_report/src/feature/patients_details/domain/entities/follows_in_case.dart';
import 'package:dio/dio.dart';
import 'package:retry/retry.dart';

import '../../../domain/entities/follows_in_case_results_dto.dart';

abstract class FollowCaseRemoteDataSource {
  Future<FollowCaseResultsDTO> getCaseFollowsByCase(int casId, bool resetPage, String accessToken);

  Future<List<FollowDetailedCase>> getAllCaseFollowsByCase(
      int casId, int? docId, String accessToken);
}

class FollowCaseRemoteDataSourceImpl implements FollowCaseRemoteDataSource {

  int _page = 0;

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  final Dio dio = Dio();

  @override
  Future<FollowCaseResultsDTO> getCaseFollowsByCase(
      int casId, bool resetPage, String accessToken) async {

    if (!_isFetching) {
      _isFetching = true;
    }

    if (resetPage) {
      _page = 0;
    }

    const r = RetryOptions(maxAttempts: 3);

    final resp =
        await r.retry(() => dio.get('$apiUrl/cases/follows/view-follow',
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

    _page++;

    final List<FollowCase> items = (resp.data["content"] as List)
        .map((item) => FollowModel.fromJson(item))
        .toList();

    return FollowCaseResultsDTOModel.fromMixedJsonAndList(resp.data, items);
  }

  Future<void> refreshFollowCases(casId, accessToken) async {
    _page = 0;
    await getCaseFollowsByCase(casId, true, accessToken);
  }

  @override
  Future<List<FollowDetailedCase>> getAllCaseFollowsByCase(
      int casId, int? docId, String accessToken) async {
    if (!_isFetching) {
      _isFetching = true;
    }

    final List<FollowDetailedCase> totalCase = [];

    const r = RetryOptions(maxAttempts: 3);

    var temp = 0;

    final queryParams = {
      "pag": temp,
      //"size"
      //'isRev'
    };

    if (docId != null) {
      queryParams["docId"] = docId;
    }

    while (isLast) {
      final resp = await r
          .retry(() => dio.get('$apiUrl/cases/operations/follows/view-group/$casId',
              options: Options(
                sendTimeout: const Duration(seconds: 3),
                receiveTimeout: const Duration(seconds: 3),
                headers: {
                  'Authorization': 'Bearer $accessToken',
                },
              ),
              queryParameters: queryParams));

      final List<FollowDetailedCase> items = (resp.data["content"] as List)
          .map((item) => FollowDetailedModel.fromJson(item))
          .toList();

      totalCase.addAll(items);

      if (resp.data['last'] == isLast) {
        break;
      }
      temp++;
    }
    return totalCase;
  }
}
