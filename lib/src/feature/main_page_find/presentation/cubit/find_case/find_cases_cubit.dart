import 'package:bloc/bloc.dart';
import 'package:d_report/src/feature/main_page_find/domain/repositories/find_cases_repository.dart';

import '../../../domain/entities/case_simple.dart';
import 'find_cases_state.dart';

class FindCasesCubit extends Cubit<FindCasesState> {
  FindCasesCubit(this._findCasesRepository) : super(FindCasesInitial());

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  final FindCasesRepository _findCasesRepository;

  Future<void> fetchSearchCases(String query, int searchKey, String accessToken,
      [bool resetPage = true, List<CaseSimple>? elementsLoaded]) async {
    final List<CaseSimple> x = [];
    bool isComplete = false;

    if (state is FindCasesLoading) return;
    if (state is FindCasesLoaded) {
      if ((state as FindCasesLoaded).cases.isNotEmpty) {
        x.addAll((state as FindCasesLoaded).cases);
      }
      if ((state as FindCasesLoaded).isComplete) {
        isComplete = (state as FindCasesLoaded).isComplete;
      }
    }
    if (state is FindCasesInitial) {
      emit(FindCasesLoading());
    }

    if (!isComplete) {
      if (_isFetching) return;
      _isFetching = true;

      try {
        final patients = await _findCasesRepository.searchCasesByKey(
            query, searchKey, resetPage, accessToken);

        patients.fold(
            (l) => emit(FindCasesFail(errorSMS: l.message)),
            (r) => r.listCasesSimple.isNotEmpty
                ? emit(resetPage
                    ? FindCasesLoaded(cases: r.listCasesSimple)
                    : FindCasesLoaded(cases: x).copyWith(
                        newCases: r.listCasesSimple, isComplete: r.isComplete))
                : emit(FindCasesLoadedButEmpty(
                    sms: "No se ha podido encontrar el caso")));
      } catch (e) {
        print('Error: $e');
        if ((state is FindCasesLoaded)) {
          emit(FindCasesLoaded(cases: (state as FindCasesLoaded).cases));
        } else {
          emit(FindCasesFail(errorSMS: "Error cargando los datos"));
        }
      } finally {
        _isFetching = false;
      }
    }
  }

  Future<void> refreshCases(
      String query, int searchKey, String accessToken) async {
    emit(FindCasesInitial());
    await fetchSearchCases(query, searchKey, accessToken);
  }
}
