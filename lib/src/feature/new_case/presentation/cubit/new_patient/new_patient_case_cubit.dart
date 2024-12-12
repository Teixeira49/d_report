import 'package:bloc/bloc.dart';
import 'package:d_report/src/feature/new_case/data/model/add_case_model.dart';
import 'package:d_report/src/feature/new_case/data/model/patient_model.dart';

import '../../../domain/entities/add_case.dart';
import '../../../domain/repository/new_case_repository.dart';
import 'new_patient_case_state.dart';

class NewCasePatientCubit extends Cubit<NewCasePatientState> {
  NewCasePatientCubit(this._newPatientCaseRepository)
      : super(NewCasePatientInitial());

  final NewCaseRepository _newPatientCaseRepository;

  Future<void> createNewCaseByNewPatient(Map<String, dynamic> patData,
      Map<String, dynamic> casData, String accessToken) async {
    try {

      emit(NewCasePatientLoading());


      final newReport = await _newPatientCaseRepository.createCaseByNewPatient(
          PatientModel.fromJson(patData), NewCaseReportModel.fromJson(casData), accessToken);

      newReport.fold((l) => emit(NewCasePatientFail(errorSMS: l.message)),
          (r) => emit(NewCasePatientLoaded(caseReport: r)));

    } catch (e) {
      print('Error: $e');
      emit(NewCasePatientFail(errorSMS: "Error cargando los datos"));
    }
  }

  Future<void> createPatient(docId, accessToken) async {
    // TODO: implement checkIfPatientExist
    throw UnimplementedError();
  }
}
