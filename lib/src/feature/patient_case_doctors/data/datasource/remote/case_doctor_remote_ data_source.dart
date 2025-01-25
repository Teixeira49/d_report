import 'package:dio/dio.dart';
import 'package:retry/retry.dart';

import '../../../../../core/utils/constants/network_constants.dart';
import '../../../domain/entities/assigned_doctor.dart';
import '../../model/assigned_doctor_model.dart';

abstract class CaseDoctorRemoteDataSource {
  Future<List<AssignedDoctor>> getDoctorsInCase(int casId, String accessToken);
}

class CaseDoctorRemoteDataSourceImpl implements CaseDoctorRemoteDataSource {
  bool _isFetching = false;

  bool get isFetching => _isFetching;

  final Dio dio = Dio();

  @override
  Future<List<AssignedDoctor>> getDoctorsInCase(
      int casId, String accessToken) async {
    if (!_isFetching) {
      _isFetching = true;
    }

    const r = RetryOptions(maxAttempts: 3);

    print('llegue');

    final resp = await r.retry(() => dio.get('$apiUrl/cases/operations/assign/view-assigned/$casId',
            options: Options(
              sendTimeout: const Duration(seconds: 3),
              receiveTimeout: const Duration(seconds: 3),
              headers: {
                'Authorization': 'Bearer $accessToken',
              },
            ),
            data: {
              'size': 10,
              'isRev': false,
            }));

    final dataF = resp.data as Map<String, dynamic>;

    print(dataF);

    final items = (dataF["content"] as List)
        .map((item) => AssignedDoctorModel.fromJson(item))
        .toList();

    print(items);

    return items;
  }
}
