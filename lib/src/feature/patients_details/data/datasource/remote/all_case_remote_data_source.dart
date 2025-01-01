import 'package:d_report/src/core/utils/constants/network_constants.dart';
import 'package:dio/dio.dart';
import 'package:retry/retry.dart';

import '../../../domain/entities/care_assignment.dart';
import '../../models/care_assignment_model.dart';
import '../../models/case_model.dart';
import '../../models/patient_model.dart';

abstract class AllCaseRemoteDataSource {
  Future<Map<String, dynamic>> getPatientData(int casId, int docId, String accessToken);

  Future<CareAssign> endAssignment(int casId, int docId, String accessToken);

  Future<CareAssign> createAssignment(int casId, int docId, String accessToken);
}


class AllCaseRemoteDataSourceImpl implements AllCaseRemoteDataSource{

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  final Dio dio = Dio();

  @override
  Future<Map<String, dynamic>> getPatientData(int casId, int docId, String accessToken) async {

    if(!_isFetching) {
      _isFetching = true;
    }

    const r = RetryOptions(maxAttempts: 3);


    final resp = await r.retry(() => dio.get(
      '$apiUrl/cases/operations/case-details',
      options: Options(
        sendTimeout: const Duration(seconds: 3),
        receiveTimeout: const Duration(seconds: 3),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
      data: {
        'casId': casId,
        'docId': docId,
      }
    ));

    return {
      "pat": PatientModel.fromJson(resp.data as Map<String, dynamic>),
      "cas": CaseReportModel.fromJson(resp.data as Map<String, dynamic>),
      "permissionStatus": resp.data['viewDetailsStatus'],
    };
  }

  @override
  Future<CareAssign> endAssignment(
      int casId, int docId, String accessToken) async {
    const r = RetryOptions(maxAttempts: 3);

    final resp = await r.retry(() =>
        dio.put('$apiUrl/cases/operations/end-assign',
            options: Options(
              sendTimeout: const Duration(seconds: 3),
              receiveTimeout: const Duration(seconds: 3),
              headers: {
                'Authorization': 'Bearer $accessToken',
              },
            ),
            data: {"casId": casId, "docId": docId}
        ));

    return CareAssignModel.fromJson(resp.data);
  }

  @override
  Future<CareAssign> createAssignment(int casId, int docId, String accessToken) async {
    const r = RetryOptions(maxAttempts: 3);

    final resp = await r.retry(() =>
        dio.post('$apiUrl/cases/operations/create-assign',
            options: Options(
              sendTimeout: const Duration(seconds: 3),
              receiveTimeout: const Duration(seconds: 3),
              headers: {
                'Authorization': 'Bearer $accessToken',
              },
            ),
            data: {"casId": casId, "docId": docId}
        ));

    return CareAssignModel.fromJson(resp.data);
  }

}