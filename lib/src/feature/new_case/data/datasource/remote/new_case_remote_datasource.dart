import 'package:d_report/src/feature/new_case/data/model/add_case_model.dart';
import 'package:d_report/src/feature/new_case/data/model/patient_model.dart';
import 'package:retry/retry.dart';

import 'package:dio/dio.dart';

import '../../../../../core/utils/constants/network_constants.dart';
import '../../../../../shared/data/model/case_model.dart';
import '../../../../../shared/domain/entities/case_report.dart';
import '../../../domain/entities/add_case.dart';
import '../../../domain/entities/patient.dart';

abstract class NewPatientCaseRemoteDataSource {
  Future<CaseReport> createCaseByNewPatient(
      Patient patData, NewCaseReport casData, String accessToken);

  Future<CaseReport> createCaseByOldPatient(
    int patData,
    NewCaseReport casData,
    String accessToken,
  );
}

class NewPatientCaseRemoteDataSourceImpl
    implements NewPatientCaseRemoteDataSource {
  final Dio dio = Dio();

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  @override
  Future<CaseReport> createCaseByNewPatient(
      Patient patData, NewCaseReport casData, String accessToken) async {
    if (!_isFetching) {
      _isFetching = true;
    }

    Map<String, dynamic> requestBody = {
      ...PatientModel.fromEntity(patData).toJson(),
      ...NewCaseReportModel.fromEntity(casData).toJson()
    };

    print('Salio del requestBody $requestBody');

    const r = RetryOptions(maxAttempts: 1);

    final resp =
        await r.retry(() => dio.post('$apiUrl/cases/patient/new/register-case/',
            options: Options(
              sendTimeout: const Duration(seconds: 2),
              receiveTimeout: const Duration(seconds: 4),
              headers: {
                'Authorization': 'Bearer $accessToken',
              },
            ),
            data: requestBody));
    //if (resp.statusCode == 200) {
    print(resp.data);

    //}
    return CaseReportModel.fromJson(resp.data);
  }

  @override
  Future<CaseReport> createCaseByOldPatient(
      int patData, NewCaseReport casData, String accessToken) async {
    Map<String, dynamic> requestBody = {
      'patId': (patData),
      ...NewCaseReportModel.fromEntity(casData).toJson()
    };

    print('Salio del requestBody $requestBody');

    const r = RetryOptions(maxAttempts: 1);

    final resp = await r
        .retry(() => dio.post('$apiUrl/cases/patient/existing/register-case/',
            options: Options(
              sendTimeout: const Duration(seconds: 2),
              receiveTimeout: const Duration(seconds: 4),
              headers: {
                'Authorization': 'Bearer $accessToken',
              },
            ),
            data: requestBody));
    //if (resp.statusCode == 200) {
    print(resp.data);

    //}
    return CaseReportModel.fromJson(resp.data);
  }
}
