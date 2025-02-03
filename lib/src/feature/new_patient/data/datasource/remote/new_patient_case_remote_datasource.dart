import 'package:d_report/src/core/utils/constants/network_constants.dart';
import 'package:retry/retry.dart';

import 'package:dio/dio.dart';

import '../../../domain/entities/patient.dart';

abstract class NewPatientCaseRemoteDataSource {

  Future<String> checkIfPatientExist(String patName, String patLastName, int patGuardianDni, String accessToken, [int? patDni]);

  Future<Patient> createPatient(Map<String, dynamic> patientData, String accessToken);

}

class NewPatientCaseRemoteDataSourceImpl implements NewPatientCaseRemoteDataSource {

  final Dio dio = Dio();

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  @override
  Future<String> checkIfPatientExist(String patName, String patLastName, int patGuardianDni, String accessToken, [int? patDni]) async {

    if(!_isFetching) {
      _isFetching = true;
    }

    const r = RetryOptions(maxAttempts: 3);

    final resp = await r.retry(
            () => dio.get(
          '$apiUrl/patients/exist-patient/$patName/$patLastName/$patGuardianDni/',
          options: Options(
            sendTimeout: const Duration(seconds: 2),
            receiveTimeout: const Duration(seconds: 2),
            headers: {
              'Authorization': 'Bearer $accessToken',
            },
          ),
          queryParameters: patDni != null ? {
            'patDni': patDni
          } : null
        )
    );

    return resp.data['error'];
  }

  @override
  Future<Patient> createPatient(Map<String, dynamic> patientData,
      String accessToken) async {
  // TODO: implement checkIfPatientExist
  throw UnimplementedError();
  }
}

