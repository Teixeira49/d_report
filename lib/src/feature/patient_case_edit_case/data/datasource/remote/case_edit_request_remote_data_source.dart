import 'package:dio/dio.dart';
import 'package:retry/retry.dart';

import '../../../../../core/utils/constants/network_constants.dart';
import '../../../domain/entities/case_report_edit_request.dart';
import '../../models/case_report_edit_request_model.dart';

abstract class CaseEditRequestRemoteDataSource {

  Future<CaseReportEditRequest> postCaseEditRequest(String accessToken);
}

class CaseEditRequestRemoteDataSourceImpl implements CaseEditRequestRemoteDataSource {

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  final Dio dio = Dio();

  @override
  Future<CaseReportEditRequest> postCaseEditRequest(String accessToken) async {
    if(!_isFetching) {
      _isFetching = true;
    }

    const r = RetryOptions(maxAttempts: 3);

    final resp = await r.retry(() => dio.post(
        '$apiUrl/cases/operations/case-details',
        options: Options(
          sendTimeout: const Duration(seconds: 3),
          receiveTimeout: const Duration(seconds: 3),
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
    ));

    return CaseReportEditRequestModel.fromJson(resp.data);
  }

}