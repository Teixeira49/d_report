import 'package:bloc/bloc.dart';
import 'package:d_report/src/feature/patients_details/data/repository/case_repository.dart';
import 'package:d_report/src/feature/patients_details/presentation/cubit/patient_data/patient_data_state.dart';

class PatientDataCubit extends Cubit<PatientDataState> {
  PatientDataCubit({required PatientRepositoryImpl patientRepositoryImpl})
      : _patientRepositoryImpl = patientRepositoryImpl,
        super(PatientDataInitial());

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  final PatientRepositoryImpl _patientRepositoryImpl;

  //final GetPatientDataUseCase useCase;

  Future<void> fetchCaseDetails(int casId, String accessToken) async {
    try {
      //final data = await useCase.call(casId);

      emit(PatientDataLoading());

      final data =
          await _patientRepositoryImpl.getPatientCaseData(casId, accessToken);

      data.fold(
          (l) => emit(PatientDataFail(errorSMS: l.message)),
          (r) => emit(PatientDataLoaded(
              patient: r.comPatient, caseReport: r.comCaseReport)));
    } catch (e) {
      print('Error: $e');
      emit(PatientDataFail(errorSMS: "Error cargando los datos"));
    } finally {
      _isFetching = false;
    }
  }

  Future<void> refreshCases(casId, accessToken) async {
    emit(PatientDataInitial());
    await fetchCaseDetails(casId, accessToken);
  }
}
