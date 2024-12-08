import 'package:bloc/bloc.dart';
import 'package:d_report/src/feature/main_page/domain/entities/case_simple.dart';
import 'package:dio/dio.dart';

import '../../../data/models/my_case_model.dart';
import 'find_cases_state.dart';

class FindCasesCubit extends Cubit<FindCasesState>{

  FindCasesCubit() : super(FindCasesInitial());

  final String accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJqYXZpZXJ0eHJAZ21haWwuY29tIiwicm9sZXMiOiJET0NUT1IiLCJpc3MiOiJodHRwOi8vMTkyLjE2OC4zMC4xOTY6OTAwMS9hcGkvYXV0aC9sb2dpbi9zaWduaW4iLCJleHAiOjE3MzM1MTYxNzl9.kS3kjYJeegiukPYhiFvIPKYjzczhv1vontaNp8TNjfw";
  int _page = 1;
  bool _isFetching = false;

  bool get isFetching => _isFetching;

  final Dio dio = Dio();

  Future<void> fetchCases(int docId) async {

    if(_isFetching) return;
    _isFetching = true;

    try {
      final resp = await dio.get(
          'http://192.168.30.196:9004/api/cases/my-cases/$docId/',
          options: Options(
            headers: {
                'Authorization': 'Bearer $accessToken',
              },
          ),
          queryParameters: {
            "pag": _page,
            "limit": 10
          },
      );
      //if (resp.statusCode == 200) {

      print(_page);

      final dataF = resp.data as Map<String, dynamic>;

      final List<CaseSimple> items = (dataF["content"] as List)
          .map((item) => MyCasesModel.fromJson(item))
          .toList();

      if (items.isNotEmpty) {
        emit(FindCasesLoaded(cases: List.from(items)));
      } else {
        emit(FindCasesLoadedButEmpty(sms: "Parece que no tienes casos pendientes"));
      }

      _page++;

      print(_page);

    }catch(e){
      print('Error: $e');
      emit(FindCasesFail(errorSMS: "Error cargando los datos"));
    }finally{
      _isFetching = false;
    }
  }
  Future<void> refreshCases(docId) async {
    _page = 1;
    emit(FindCasesInitial());
    await fetchCases(docId);
  }
}