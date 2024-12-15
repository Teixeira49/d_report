import 'package:d_report/src/feature/end_case/domain/entities/end_case_dto.dart';
import 'package:dio/dio.dart';
import 'package:retry/retry.dart';

import 'package:d_report/src/shared/data/model/case_model.dart';
import '../../../../../shared/domain/entities/case_report.dart';

abstract class EndCaseRemoteDataSource {
  Future<CaseReport> endCase(EndCaseDTO endCaseStatus, String accessToken);
}


class EndCaseRemoteDataSourceImpl implements EndCaseRemoteDataSource{

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  final Dio dio = Dio();

  @override
  Future<CaseReport> endCase(EndCaseDTO endCaseStatus, String accessToken) async { // TODO change location of code
    if(!_isFetching) {
      _isFetching = true;
    }

    const r = RetryOptions(maxAttempts: 3);


    final resp = await r.retry(() => dio.put(
        'http://192.168.30.196:9004/api/cases/patient/close-case',
        options: Options(
          sendTimeout: const Duration(seconds: 3),
          receiveTimeout: const Duration(seconds: 3),
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
        data: {
          'patId': endCaseStatus.encPatId,
          'casId': endCaseStatus.encCasId,
          'casEndReason': endCaseStatus.encEndReason
        }
    ));

    return CaseReportModel.fromJson(resp.data);
  }
}