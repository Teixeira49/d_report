import 'package:d_report/src/feature/patient_case_doctors/data/model/view_doctors.dart';
import 'package:dio/dio.dart';
import 'package:retry/retry.dart';

import '../../../../../core/utils/constants/network_constants.dart';
import '../../../domain/entities/assigned_doctor.dart';
import '../../../domain/entities/view_doctors.dart';
import '../../model/assigned_doctor_model.dart';

abstract class CaseDoctorRemoteDataSource {
  Future<ViewDoctors> getDoctorsInCase(int casId, bool resetPage, String accessToken);
}

class CaseDoctorRemoteDataSourceImpl implements CaseDoctorRemoteDataSource {
  bool _isFetching = false;

  bool get isFetching => _isFetching;

  int _page = 0;

  final Dio dio = Dio();

  @override
  Future<ViewDoctors> getDoctorsInCase(
      int casId, bool resetPage, String accessToken) async {
    if (!_isFetching) {
      _isFetching = true;
    }

    if (resetPage) {
      _page = 0;
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
              'pag': _page,
            }));

    final dataF = resp.data as Map<String, dynamic>;

    final items = (dataF["content"] as List)
        .map((item) => AssignedDoctorModel.fromJson(item))
        .toList();

    return ViewDoctorsModel.fromMixed(items, dataF);
  }
}
