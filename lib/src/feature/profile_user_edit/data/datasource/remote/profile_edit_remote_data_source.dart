import 'package:retry/retry.dart';

import 'package:dio/dio.dart';

import '../../../../../core/utils/constants/network_constants.dart';
import '../../../../../shared/data/model/profile_model.dart';
import '../../../../../shared/domain/entities/doctor.dart';
import '../../../domain/entities/profile_doctor_request.dart';
import '../../models/profile_doctor_request_model.dart';

abstract class ProfileEditRemoteDataSource {
  Future<DoctorProfile> putDoctorProfile(
      DoctorProfileRequest profileRequest, String email, String accessToken);
}

class ProfileEditRemoteDataSourceImpl implements ProfileEditRemoteDataSource {
  final Dio dio = Dio();

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  @override
  Future<DoctorProfile> putDoctorProfile(DoctorProfileRequest profileRequest,
      String email, String accessToken) async {
    if (!_isFetching) {
      _isFetching = true;
    }

    const r = RetryOptions(maxAttempts: 3);

    print(DoctorProfileRequestModel.fromEntity(profileRequest).toRequestBody());

    final resp = await r.retry(() => dio.put('$apiUrl/doctors/edit',
        options: Options(
          sendTimeout: const Duration(seconds: 2),
          receiveTimeout: const Duration(seconds: 2),
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
        data: DoctorProfileRequestModel.fromEntity(profileRequest)
            .toRequestBody()));

    print(resp.data);

    return DoctorProfileModel.fromJsonWithEmail(
        resp.data, email, profileRequest.range);
  }

  Future<void> refreshDoctor(docId, email, accessToken) async {
    await putDoctorProfile(docId, email, accessToken);
  }
}
