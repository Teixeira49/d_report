import 'package:dio/dio.dart';
import 'package:retry/retry.dart';

import '../../../../../core/utils/constants/network_constants.dart';
import '../../../domain/entities/patient_guardian_edit_request.dart';
import '../../models/patient_guardian_edit_request_model.dart';

abstract class PatientGuardianEditRequestRemoteDataSource {

  Future<PatientGuardianEditRequest> postPatientGuardianEditRequest(PatientGuardianEditRequest patientGuardianEditRequest, String accessToken);
}

class PatientGuardianEditRequestRemoteDataSourceImpl implements PatientGuardianEditRequestRemoteDataSource {

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  final Dio dio = Dio();

  @override
  Future<PatientGuardianEditRequest> postPatientGuardianEditRequest(PatientGuardianEditRequest patientGuardianEditRequest, String accessToken) async {
    if(!_isFetching) {
      _isFetching = true;
    }

    const r = RetryOptions(maxAttempts: 3);

    final resp = await r.retry(() => dio.post(
        '$apiUrl/patients/guardians/edit',
        options: Options(
          sendTimeout: const Duration(seconds: 3),
          receiveTimeout: const Duration(seconds: 3),
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
        data: PatientGuardianEditRequestModel.fromEntity(patientGuardianEditRequest)
            .toJson()));

    return PatientGuardianEditRequestModel.fromJson(resp.data);
  }

}