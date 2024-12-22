import 'package:retry/retry.dart';

import 'package:dio/dio.dart';


import '../../../domain/entities/patient.dart';
import '../../model/patient_model.dart';

abstract class FindPatientRemoteDataSource {
  Future<List<SearchPatient>> searchPatients(
      String query, int searchKey, String accessToken);
}

class FindPatientRemoteDataSourceImpl implements FindPatientRemoteDataSource {
  final Dio dio = Dio();

  int _page = 1;

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  @override
  Future<List<SearchPatient>> searchPatients(
      String query, int searchKey, String accessToken) async {
    if (!_isFetching) {
      _isFetching = true;
    }

    const r = RetryOptions(maxAttempts: 3);

    final resp = await r.retry(() => dio.get(
            'http://192.168.30.196:9004/api/patients/search',
            options: Options(
              sendTimeout: const Duration(seconds: 2),
              receiveTimeout: const Duration(seconds: 2),
              headers: {
                'Authorization': 'Bearer $accessToken',
              },
            ),
            queryParameters: {
              'q': query,
              'findBy': searchKey,
              'pag': _page,
            }));
    //if (resp.statusCode == 200) {

    final dataF = resp.data as Map<String, dynamic>;

    final items = (dataF["content"] as List)
        .map((item) => PatientModel.fromJson(item))
        .toList();

    _page++;

    print(resp.data);
    print('Mis items $items');

    return items;

  }

  Future<void> refreshPatients(query, searchKey, accessToken) async {
    _page = 1;
    await searchPatients(query, searchKey, accessToken);
  }
}
