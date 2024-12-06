import 'package:bloc/bloc.dart';
import 'package:d_report/src/feature/patient_case_follow_details/domain/repository/follow_detailed_case_repository.dart';

import 'package:flutter/foundation.dart';


import 'follow_detailed_report_state.dart';


class FollowDetailedReportCubit extends Cubit<FollowDetailedReportState>{

  FollowDetailedReportCubit({required FollowDetailedRepositoryImpl followDetailedRepositoryImpl}) : _followDetailedRepositoryImpl = followDetailedRepositoryImpl, super(FollowDetailedCaseInitial());

  final String accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJqYXZpZXJ0eHJAZ21haWwuY29tIiwicm9sZXMiOiJET0NUT1IiLCJpc3MiOiJodHRwOi8vMTkyLjE2OC4zMC4xOTY6OTAwMS9hcGkvYXV0aC9sb2dpbi9zaWduaW4iLCJleHAiOjE3MzM0NDM5ODN9.SbkUtS9LqI8fKUUUFQt0CCkaqgnD0oeHhidlPCe9NqA";
  bool _isFetching = false;

  bool get isFetching => _isFetching;

  //final GetPatientDataUseCase useCase;

  final FollowDetailedRepositoryImpl _followDetailedRepositoryImpl;

  Future<void> fetchFollowCaseDetails(int cafId) async {

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
  Future<void> refreshGetCaseFollowsByCase(docId) async {
    emit(FollowDetailedCaseInitial());
    await fetchFollowCaseDetails(docId);
  }

}