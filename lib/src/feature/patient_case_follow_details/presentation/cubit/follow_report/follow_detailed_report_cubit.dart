import 'package:bloc/bloc.dart';
import 'package:d_report/src/feature/patient_case_follow_details/domain/repository/follow_detailed_case_repository.dart';

import 'package:flutter/foundation.dart';


import 'follow_detailed_report_state.dart';


class FollowDetailedReportCubit extends Cubit<FollowDetailedReportState>{

  FollowDetailedReportCubit({required FollowDetailedRepositoryImpl followDetailedRepositoryImpl}) : _followDetailedRepositoryImpl = followDetailedRepositoryImpl, super(FollowDetailedCaseInitial());

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  //final GetPatientDataUseCase useCase;

  final FollowDetailedRepositoryImpl _followDetailedRepositoryImpl;

  Future<void> fetchFollowCaseDetails(int cafId, String accessToken) async {

    try{

      final data = await _followDetailedRepositoryImpl.getCaseFollowsByCase(cafId, accessToken);

      emit(FollowDetailedCaseLoaded(followDetailedCase: data));


    }catch(e){
      print('Error: $e');
      emit(FollowDetailedCaseFail(errorSMS: "Error cargando los datos"));
    }finally{
      _isFetching = false;
    }

  }

  Future<void> refreshGetCaseFollowsByCase(casId, accessToken) async {
    emit(FollowDetailedCaseInitial());
    await fetchFollowCaseDetails(casId, accessToken);
  }

}