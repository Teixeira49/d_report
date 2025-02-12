import 'package:bloc/bloc.dart';
import 'package:d_report/src/feature/main_page/domain/entities/case_simple.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:retry/retry.dart';


import '../../../data/models/my_case_model.dart';
import '../../../domain/repositories/my_cases_repository.dart';
import 'my_cases_state.dart';

class MyCasesCubit extends Cubit<MyCasesState>{

  int _page = 0;
/*
  final String accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJqYXZpZXJ0eHJAZ21haWwuY29tIiwicm9sZXMiOiJET0NUT1IiLCJpc3MiOiJodHRwOi8vMTkyLjE2OC4zMC4xOTY6OTAwMS9hcGkvYXV0aC9sb2dpbi9zaWduaW4iLCJleHAiOjE3MzM2MTQzOTZ9.81MvIEuf4JyqBUWBxtba0eOPEboKguA8X18FzlrYUMY";
  bool _isFetching = false;

  bool get isFetching => _isFetching;

  final Dio dio = Dio();
*/
  MyCasesCubit(this._myCasesRepository) : super(MyCasesInitial());

  final MyCasesRepository _myCasesRepository;

  Future<void> fetchCases(int docId, String accessToken) async {

    //if(_isFetching) return;
    //_isFetching = true;

    //const r = RetryOptions(maxAttempts: 3);

    try {
      emit(MyCasesLoading());

      final cases = await _myCasesRepository.getMyCasesById(docId, accessToken);

      List<CaseSimple> finalList = cases.getOrElse(() => []);

      cases.fold(
              (l) => emit(MyCasesFail(errorSMS: l.message)),
              (r) => r.isNotEmpty
          ? emit(MyCasesLoaded(cases: finalList))
          : emit(MyCasesLoadedButEmpty(
                  sms: "Parece que no tienes casos pendientes"))
      );

      /*final resp = await r.retry(
        () => dio.get(
          'http://192.168.30.196:9004/api/cases/my-cases/$docId/',
          options: Options(
            sendTimeout: const Duration(seconds: 3),
            receiveTimeout: const Duration(seconds: 3),
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
      if (resp.statusCode == 200) {

        final dataF = resp.data as Map<String, dynamic>;

        final List<CaseSimple> items = (dataF["content"] as List)
            .map((item) => MyCasesModel.fromJson(item))
            .toList();

        if (items.isNotEmpty) {
          emit(MyCasesLoaded(cases: List.from(items)));
        } else {
          emit(MyCasesLoadedButEmpty(
              sms: "Parece que no tienes casos pendientes"));
        }
      } else {
        emit(MyCasesTimeout(sms: "Revise su conexion a internet para continuar"));
      }

      _page++;

      print(_page);
*/
    }catch(e){
      print('Error: $e');
      emit(MyCasesFail(errorSMS: "Fallo conexion con el Servidor"));
    }//finally{
     // _isFetching = false;
    //}
  }

  Future<void> refreshCases(int docId, String accessToken) async {
    await _myCasesRepository.getRefreshMyCasesById();
    emit(MyCasesInitial());
    fetchCases(docId, accessToken);
  }

  void updateFilter(String filter) {
    if (state is MyCasesLoaded) {
      final loadedState = state as MyCasesLoaded;
      emit(loadedState.copyWith(filter: filter));
    }
  }
}