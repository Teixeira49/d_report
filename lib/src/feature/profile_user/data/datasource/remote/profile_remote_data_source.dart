import 'package:d_report/src/feature/profile_user/data/models/profile_model.dart';
import 'package:retry/retry.dart';

import 'package:dio/dio.dart';

import '../../../../../core/utils/constants/network_constants.dart';
import '../../../domain/entities/doctor.dart';

abstract class ProfileRemoteDataSource {
  Future<Doctor> getDoctorById(int docId, String accessToken);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {

  final Dio dio = Dio();

  int _page = 1;

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  @override
  Future<Doctor> getDoctorById(int docId, String accessToken) async {

    if(!_isFetching) {
      _isFetching = true;
    }

    const r = RetryOptions(maxAttempts: 3);

    final resp = await r.retry(
            () => dio.get(
          '$apiUrl/doctors/doctor/find-by/doc-id/$docId/',
          options: Options(
            sendTimeout: const Duration(seconds: 2),
            receiveTimeout: const Duration(seconds: 2),
            headers: {
              'Authorization': 'Bearer $accessToken',
            },
          ),
        )
    );

    print(resp.data);

    return DoctorModel.fromJson(resp.data);
  }

  Future<void> refreshDoctor(docId, accessToken) async {
    await getDoctorById(docId, accessToken);
  }
}
