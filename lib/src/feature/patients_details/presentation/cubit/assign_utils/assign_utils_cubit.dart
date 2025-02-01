import 'package:bloc/bloc.dart';
import 'package:d_report/src/feature/patients_details/data/repository/case_repository.dart';

import 'assign_utils_state.dart';


class AssignUtilsCubit extends Cubit<AssignUtilsState>{

  AssignUtilsCubit({required PatientRepositoryImpl patientRepositoryImpl}) : _patientRepositoryImpl = patientRepositoryImpl, super(AssignUtilsInitial());

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  final PatientRepositoryImpl _patientRepositoryImpl;

  Future<void> fetchEndAssignDetails(int casId, int docId, String accessToken) async {

    try{

      emit(AssignUtilsLoading());

      final data = await _patientRepositoryImpl.endAssignment(casId, docId, accessToken);

      data.fold(
              (l) => emit(AssignUtilsFail(errorSMS: l.message)),
              (r) => emit(AssignUtilsLoaded(sms: 'Se ha retirado del caso correctamente', endAssign: r))
      );

    }catch(e){
      emit(AssignUtilsFail(errorSMS: "Error cargando los datos"));
    }finally{
      _isFetching = false;
    }

  }

  Future<void> createNewAssign(int casId, int docId, String accessToken) async {

    try{

      emit(AssignUtilsLoading());

      final data = await _patientRepositoryImpl.createAssignment(casId, docId, accessToken);

      data.fold(
              (l) => emit(AssignUtilsFail(errorSMS: l.message)),
              (r) => emit(AssignUtilsLoaded(sms: 'Se ha vinculado Correctamente', endAssign: r))
      );

    }catch(e){
      emit(AssignUtilsFail(errorSMS: "Error cargando los datos"));
    }finally{
      _isFetching = false;
    }
  }
}