
import 'package:d_report/src/feature/patients_details/domain/entities/end_case_dto.dart';
import 'package:d_report/src/shared/data/model/case_model.dart';
import 'package:dio/dio.dart';
import 'package:retry/retry.dart';

import '../../../../../shared/domain/entities/case_report.dart';
import '../../models/patient_model.dart';

abstract class AllCaseRemoteDataSource {
  Future<Map<String, dynamic>> getPatientData(int casId, String accessToken);

  Future<CaseReport> endCase(EndCaseDTO patientStatus, String accessToken);
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

  @override
  Future<CaseReport> endCase(EndCaseDTO patientStatus, String accessToken) async {
    if(!_isFetching) {
      _isFetching = true;
    }

    const r = RetryOptions(maxAttempts: 3);


    final resp = await r.retry(() => dio.get(
      'http://192.168.30.196:9004/api/cases/patient/close-case',
      options: Options(
        sendTimeout: const Duration(seconds: 3),
        receiveTimeout: const Duration(seconds: 3),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
      data: {
        'patId': patientStatus.encPatId,
        'casId': patientStatus.encCasId,
        'casEndReason': patientStatus.encEndReason
      }
    ));

    return CaseReportModel.fromJson(resp);
  }



}