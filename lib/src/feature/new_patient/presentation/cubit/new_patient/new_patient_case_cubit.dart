import 'package:bloc/bloc.dart';

import '../../../domain/repository/new_patient_case_repository.dart';
import 'new_patient_case_state.dart';

class CheckPatientCubit extends Cubit<CheckPatientState>{

  CheckPatientCubit(this._newPatientCaseRepository) : super(CheckPatientInitial());

  final NewPatientCaseRepository _newPatientCaseRepository;

  Future<void> checkIfPatientExist(String patName, String patLastName, int patGuardianDni, String accessToken, [int? patDni]) async {

    try {
      emit(CheckPatientLoading());

      final sms = await _newPatientCaseRepository.checkIfPatientExist(patName, patLastName, patGuardianDni, accessToken, patDni);

      sms.fold(
              (l) => emit(CheckPatientFail(errorSMS: "Error de conexion subiendo los datos")),
              (r) => emit(CheckPatientLoaded(sms: r))
      );

    }catch(e){
      print('Error: $e');
      emit(CheckPatientFail(errorSMS: "Error cargando los datos"));
    }
  }

  Future<void> createPatient(docId, accessToken) async {
    // TODO: implement checkIfPatientExist
    throw UnimplementedError();
  }
}