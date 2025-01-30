import 'package:d_report/src/core/utils/constants/network_constants.dart';
import 'package:retry/retry.dart';

import 'package:dio/dio.dart';

import '../models/my_case_model.dart';

abstract class FindCasesRemoteDataSource {
  Future<List<MyCasesModel>> searchCases(
      String query, int searchKey, bool resetPage, String accessToken);
}

class FindCasesRemoteDataSourceImpl implements FindCasesRemoteDataSource {
  final Dio dio = Dio();

  int _page = 0;

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  @override
  Future<List<MyCasesModel>> searchCases(
      String query, int searchKey, bool resetPage, String accessToken) async {
    if (!_isFetching) {
      _isFetching = true;
    }

    if (resetPage) {
      _page = 0;
    }

    const r = RetryOptions(maxAttempts: 3);

    print('a');

    final resp = await r.retry(() => dio.get(
          '$apiUrl/cases/search',
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
          },
        ));
    //if (resp.statusCode == 200) {
    print(resp.data);
    final dataF = resp.data as Map<String, dynamic>;
    //print(jsonDecode(resp.data));

    final items = (dataF["content"] as List)
        .map((item) => MyCasesModel.fromJson(item))
        .toList();

    _page++;

    print(resp.data);
    print('Mis items $items');
    //}
    return items;
  }

  Future<void> refreshCases(String query, int searchKey, accessToken) async {
    _page = 0;
    await searchCases(query, searchKey, true, accessToken);
  }
}
