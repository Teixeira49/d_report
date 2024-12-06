
import 'package:d_report/src/feature/patients_details/data/models/case_model.dart';
import 'package:dio/dio.dart';
import 'package:retry/retry.dart';

import '../../models/patient_model.dart';

abstract class AllCaseRemoteDataSource {
  Future<Map<String, dynamic>> getPatientData(int casId, String accessToken);
}


class AllCaseRemoteDataSourceImpl implements AllCaseRemoteDataSource{

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  final Dio dio = Dio();

  @override
  Future<Map<String, dynamic>> getPatientData(int casId, String accessToken) async {

    if(!_isFetching) {
      _isFetching = true;
    }

    const r = RetryOptions(maxAttempts: 3);


    final resp = await r.retry(() => dio.get(
      'http://192.168.30.196:9004/api/cases/find-by/cas-id/$casId/',
      options: Options(
        sendTimeout: const Duration(seconds: 3),
        receiveTimeout: const Duration(seconds: 3),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    ));

    return {
      "pat": PatientModel.fromJson(resp.data as Map<String, dynamic>),
      "cas": CaseReportModel.fromJson(resp.data as Map<String, dynamic>)
    };
  }

}