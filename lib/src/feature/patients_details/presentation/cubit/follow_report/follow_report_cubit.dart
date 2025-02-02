import 'package:bloc/bloc.dart';
import 'package:d_report/src/feature/patients_details/data/repository/follow_case_repository.dart';

import '../../../domain/entities/follows_in_case.dart';
import 'follow_report_state.dart';

class FollowReportCubit extends Cubit<FollowReportState> {
  FollowReportCubit({required FollowRepositoryImpl followRepositoryImpl})
      : _followRepositoryImpl = followRepositoryImpl,
        super(FollowCaseInitial());

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  final FollowRepositoryImpl _followRepositoryImpl;

  Future<void> fetchFollowCaseDetails(int casId, String accessToken,
      [bool resetPage = true]) async {
    final List<FollowCase> inList = [];
    bool isComplete = false;

    if (state is FollowCaseLoading) return;
    if (state is FollowCaseLoaded) {
      if ((state as FollowCaseLoaded).followCase.isNotEmpty) {
        inList.addAll((state as FollowCaseLoaded).followCase);
      }
      if ((state as FollowCaseLoaded).isComplete) {
        isComplete = (state as FollowCaseLoaded).isComplete;
      }
    }
    if (state is FollowCaseInitial) {
      emit(FollowCaseLoading());
    }

    if (!isComplete) {
      if (_isFetching) return;
      _isFetching = true;
      try {
        final data = await _followRepositoryImpl.getCaseFollowsByCase(
            casId, resetPage, accessToken);

        data.fold((l) => emit(FollowCaseFail(errorSMS: l.message)), (r) {
          if (r.followsList.isEmpty) {
            emit(FollowCaseLoadedButEmpty(
                sms:
                    "Este paciente no posee Seguimiento, porfavor, cree uno para empezar."));
          } else {
            emit(resetPage
                ? FollowCaseLoaded(
                    followCase: r.followsList, countTotal: r.followsCountTotal)
                : FollowCaseLoaded(
                        followCase: inList, countTotal: r.followsCountTotal)
                    .copyWith(
                        follows: r.followsList,
                        isComplete: r.followsIsComplete));
          }
        });
      } catch (e) {
        print('Error: $e');
        emit(FollowCaseFail(errorSMS: "Error cargando los datos."));
      } finally {
        _isFetching = false;
      }
    }
  }

  Future<void> refreshCases(casId, accessToken) async {
    emit(FollowCaseInitial());
    await fetchFollowCaseDetails(casId, accessToken);
  }
}
