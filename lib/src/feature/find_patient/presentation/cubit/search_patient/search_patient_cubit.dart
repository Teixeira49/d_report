import 'package:bloc/bloc.dart';
import 'package:d_report/src/feature/find_patient/presentation/cubit/search_patient/search_patient_state.dart';

import '../../../domain/entities/patient.dart';
import '../../../domain/repository/find_patient_reporitory.dart';

class FindPatientCubit extends Cubit<FindPatientState> {
  FindPatientCubit(this._findPatientRepository) : super(FindPatientInitial());

  final FindPatientRepository _findPatientRepository;

  Future<void> findPatients(
      String query, int searchKey, String accessToken) async {
    try {
      emit(FindPatientLoading());

      final patients = await _findPatientRepository.searchPatients(
          query, searchKey, accessToken);

      patients.fold(
          (l) => emit(FindPatientFail(errorSMS: "Error del servidor")),
          (r) => r.isNotEmpty
              ? emit(FindPatientLoaded(patients: r))
              : emit(FindPatientLoadedButEmpty(
                  sms: "Parece que no tienes casos pendientes")));

    } catch (e) {
      print('Error: $e');
      emit(FindPatientFail(errorSMS: "Error cargando los datos"));
    }
  }

  Future<void> refreshPatients(query, searchKey, accessToken) async {
    emit(FindPatientInitial());

    await findPatients(query, searchKey, accessToken);
  }
}
