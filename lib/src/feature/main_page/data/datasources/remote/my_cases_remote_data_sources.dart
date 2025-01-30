import 'package:retry/retry.dart';

import '../../../../../core/utils/constants/network_constants.dart';
import '../../models/my_case_model.dart';
import 'package:dio/dio.dart';

abstract class MyCasesRemoteDataSource {
  Future<List<MyCasesModel>> getMyCases(int docId, String accessToken);

  Future<void> getRefreshMyCases();
}

class MyCasesRemoteDataSourceImpl implements MyCasesRemoteDataSource {

  final Dio dio = Dio();

  int _page = 0;

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  @override
  Future<List<MyCasesModel>> getMyCases(int docId, String accessToken) async {

    if(!_isFetching) {
      _isFetching = true;
    }

    List<MyCasesModel> totalList = [];

    while(true) {
      const r = RetryOptions(maxAttempts: 3);

      final resp = await r.retry(
              () => dio.get(
            '$apiUrl/cases/my-cases/$docId/',
            options: Options(
              sendTimeout: const Duration(seconds: 2),
              receiveTimeout: const Duration(seconds: 2),
              headers: {
                'Authorization': 'Bearer $accessToken',
              },
            ),
            queryParameters: {
              "pag": _page,
              "limit": 10
            },
          )
      );
      //if (resp.statusCode == 200) {
      //print(resp.data);
      final dataF = resp.data as Map<String, dynamic>;
      //print(jsonDecode(resp.data));

      final items = (dataF["content"] as List)
          .map((item) => MyCasesModel.fromJson(item))
          .toList();

      totalList.addAll(items);

      _page++;

      print('Mis items $items');
      //}
      print(_page);
      if (dataF['last'] == true) {
        break;
      }
    }

    print(totalList);

    return totalList;
  }

  @override
  Future<void> getRefreshMyCases() async {
    print('object');
    _page = 0;
  }
}

