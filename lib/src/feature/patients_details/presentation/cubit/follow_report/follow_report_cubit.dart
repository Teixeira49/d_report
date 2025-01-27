import 'package:bloc/bloc.dart';
import 'package:d_report/src/feature/patients_details/data/repository/follow_case_repository.dart';
import 'package:flutter/foundation.dart';


import 'follow_report_state.dart';


class FollowReportCubit extends Cubit<FollowReportState>{

  FollowReportCubit({required FollowRepositoryImpl followRepositoryImpl}) : _followRepositoryImpl = followRepositoryImpl, super(FollowCaseInitial());

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  //final GetPatientDataUseCase useCase;

  final FollowRepositoryImpl _followRepositoryImpl;

  Future<void> fetchFollowCaseDetails(int casId, String accessToken) async {

    try{

      emit(FollowCaseLoading());

      final data = await _followRepositoryImpl.getCaseFollowsByCase(casId, accessToken);

      data.fold(
              (l) => emit(FollowCaseFail(errorSMS: l.message)),
              (r) {
              if (r.isEmpty) {
                emit(FollowCaseLoadedButEmpty(sms: "Este paciente no posee Seguimiento, porfavor, cree uno para empezar."));
              } else {
                emit(FollowCaseLoaded(followCase: r));
              }}
      );

    }catch(e){
      print('Error: $e');
      emit(FollowCaseFail(errorSMS: "Error cargando los datos."));
    }finally{
      _isFetching = false;
    }
  }

  Future<void> refreshCases(casId, accessToken) async {
    emit(FollowCaseInitial());
    await fetchFollowCaseDetails(casId, accessToken);
  }
}