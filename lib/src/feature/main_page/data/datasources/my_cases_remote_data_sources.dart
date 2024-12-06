import 'dart:convert';

import '../models/my_case_model.dart';
import 'package:dio/dio.dart';

abstract class MyCasesRemoteDataSource {
  Future<MyCasesModel> getMyCases(int docId);
}

class MyCasesRemoteDataSourceImpl implements MyCasesRemoteDataSource {

  final String accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJqYXZpZXJ0eHJAZ21haWwuY29tIiwicm9sZXMiOiJET0NUT1IiLCJpc3MiOiJodHRwOi8vMTkyLjE2OC4zMC4xOTY6OTAwMS9hcGkvYXV0aC9sb2dpbi9zaWduaW4iLCJleHAiOjE3MzM0NDM5ODN9.SbkUtS9LqI8fKUUUFQt0CCkaqgnD0oeHhidlPCe9NqA";
  final Dio dio = Dio();

  @override
  Future<MyCasesModel> getMyCases(int docId) async {

    final resp = await dio.get(
      'http://192.168.30.196:9004/api/cases/my-cases/$docId/',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        }
      ),
    );
    //if (resp.statusCode == 200) {
    print(resp.data);
    final dataF = resp.data as Map<String, dynamic>;
    print(jsonDecode(resp.data));

    final items = (dataF["content"] as List)
        .map((item) => MyCasesModel.fromJson(item))
        .toList();

    print(items);
    //}
    return MyCasesModel.fromJson(resp.data);
  }
}