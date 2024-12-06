import 'package:bloc/bloc.dart';
import 'package:d_report/src/feature/patients_details/data/repository/patient_repository.dart';
import 'package:d_report/src/feature/patients_details/presentation/cubit/patient_data/patient_data_state.dart';


class PatientDataCubit extends Cubit<PatientDataState>{

  PatientDataCubit({required PatientRepositoryImpl patientRepositoryImpl}) : _patientRepositoryImpl = patientRepositoryImpl, super(PatientDataInitial());

  final String accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJqYXZpZXJ0eHJAZ21haWwuY29tIiwicm9sZXMiOiJET0NUT1IiLCJpc3MiOiJodHRwOi8vMTkyLjE2OC4zMC4xOTY6OTAwMS9hcGkvYXV0aC9sb2dpbi9zaWduaW4iLCJleHAiOjE3MzM0NDM5ODN9.SbkUtS9LqI8fKUUUFQt0CCkaqgnD0oeHhidlPCe9NqA";
  bool _isFetching = false;

  bool get isFetching => _isFetching;

  final PatientRepositoryImpl _patientRepositoryImpl;
  //final GetPatientDataUseCase useCase;

  Future<void> fetchCaseDetails(int casId) async {

    try{

      //final data = await useCase.call(casId);

      final data = await _patientRepositoryImpl.getPatientCaseData(casId, accessToken);

      emit(PatientDataLoaded(patient: data.comPatient, caseReport: data.comCaseReport));

    }catch(e){
      print('Error: $e');
      emit(PatientDataFail(errorSMS: "Error cargando los datos"));
    }finally{
      _isFetching = false;
    }


  }
  Future<void> refreshCases(docId) async {
    emit(PatientDataInitial());
    await fetchCaseDetails(docId);
  }

}