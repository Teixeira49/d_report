import 'package:bloc/bloc.dart';
import 'package:d_report/src/feature/patients_details/data/repository/follow_case_repository.dart';
import 'package:flutter/foundation.dart';


import 'follow_report_state.dart';


class FollowReportCubit extends Cubit<FollowReportState>{

  FollowReportCubit({required FollowRepositoryImpl followRepositoryImpl}) : _followRepositoryImpl = followRepositoryImpl, super(FollowCaseInitial());

  final String accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJqYXZpZXJ0eHJAZ21haWwuY29tIiwicm9sZXMiOiJET0NUT1IiLCJpc3MiOiJodHRwOi8vMTkyLjE2OC4zMC4xOTY6OTAwMS9hcGkvYXV0aC9sb2dpbi9zaWduaW4iLCJleHAiOjE3MzM0NDM5ODN9.SbkUtS9LqI8fKUUUFQt0CCkaqgnD0oeHhidlPCe9NqA";
  bool _isFetching = false;

  bool get isFetching => _isFetching;

  //final GetPatientDataUseCase useCase;

  final FollowRepositoryImpl _followRepositoryImpl;

  Future<void> fetchFollowCaseDetails(int casId) async {

    try{

      final data = await _followRepositoryImpl.getCaseFollowsByCase(casId, accessToken);

      if (data.isEmpty) {
        emit(FollowCaseLoadedButEmpty(sms: "Este paciente no posee Seguimiento, porfavor, cree uno"));
      }else {
        emit(FollowCaseLoaded(followCase: data));
      }

    }catch(e){
      print('Error: $e');
      emit(FollowCaseFail(errorSMS: "Error cargando los datos"));
    }finally{
      _isFetching = false;
    }

  }
  Future<void> refreshCases(docId) async {
    emit(FollowCaseInitial());
    await fetchFollowCaseDetails(docId);
  }

}