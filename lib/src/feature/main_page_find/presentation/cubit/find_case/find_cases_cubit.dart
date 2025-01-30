import 'package:bloc/bloc.dart';
import 'package:d_report/src/feature/main_page_find/domain/repositories/find_cases_repository.dart';

import 'find_cases_state.dart';

class FindCasesCubit extends Cubit<FindCasesState>{

  FindCasesCubit(this._findCasesRepository) : super(FindCasesInitial());

  int _page = 0;
  bool _isFetching = false;

  bool get isFetching => _isFetching;

  final FindCasesRepository _findCasesRepository;


  Future<void> fetchSearchCases(String query, int searchKey, String accessToken, [bool resetPage = true]) async {

    if(_isFetching) return;
    _isFetching = true;

    try {

      emit(FindCasesLoading());

      print('are[a $query');
      final patients = await _findCasesRepository.searchCasesByKey(query, searchKey, resetPage, accessToken);
      print('casos $patients');

      patients.fold(
              (l) => emit(FindCasesFail(errorSMS: l.message)),
              (r) => r.isNotEmpty
              ? emit(FindCasesLoaded(cases: r))
              : emit(FindCasesLoadedButEmpty(
              sms: "No se ha podido encontrar el caso")));

    }catch(e){
      print('Error: $e');
      emit(FindCasesFail(errorSMS: "Error cargando los datos"));
    }finally{
      _isFetching = false;
    }
  }

  Future<void> refreshCases(String query, int searchKey, String accessToken) async {
    _page = 0;
    emit(FindCasesInitial());
    await fetchSearchCases(query, searchKey, accessToken);
  }
}