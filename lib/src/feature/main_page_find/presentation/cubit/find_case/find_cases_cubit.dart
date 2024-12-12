import 'package:bloc/bloc.dart';

import 'find_cases_state.dart';

class FindCasesCubit extends Cubit<FindCasesState>{

  FindCasesCubit() : super(FindCasesInitial());

  int _page = 1;
  bool _isFetching = false;

  bool get isFetching => _isFetching;


  Future<void> fetchCases(int docId) async {

    if(_isFetching) return;
    _isFetching = true;

    try {


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