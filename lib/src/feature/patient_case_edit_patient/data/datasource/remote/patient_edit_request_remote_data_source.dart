import 'package:dio/dio.dart';
import 'package:retry/retry.dart';

import '../../../../../core/utils/constants/network_constants.dart';
import '../../../domain/entities/patient_edit_request.dart';
import '../../models/patient_report_edit_request_model.dart';

abstract class PatientEditRequestRemoteDataSource {
  Future<PatientEditRequest> postPatientEditRequest(
      PatientEditRequest patientEditRequest, int part, String accessToken);
}

class PatientEditRequestRemoteDataSourceImpl
    implements PatientEditRequestRemoteDataSource {
  bool _isFetching = false;

  bool get isFetching => _isFetching;

  final Dio dio = Dio();

  @override
  Future<PatientEditRequest> postPatientEditRequest(
      PatientEditRequest patientEditRequest,
      int part,
      String accessToken) async {
    if (!_isFetching) {
      _isFetching = true;
    }

    const r = RetryOptions(maxAttempts: 3);

    print(PatientEditRequestModel.fromEntity(patientEditRequest)
        .toSubJson(part));

    final resp = await r.retry(() => dio.put('$apiUrl/patients/edit',
        options: Options(
          sendTimeout: const Duration(seconds: 3),
          receiveTimeout: const Duration(seconds: 3),
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
        data: PatientEditRequestModel.fromEntity(patientEditRequest)
            .toSubJson(part)));

    return PatientEditRequestModel.fromJson(resp.data);
  }
}
