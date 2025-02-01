import 'package:bloc/bloc.dart';

import '../../../domain/entities/patient.dart';
import '../../../domain/repository/find_patient_reporitory.dart';
import 'search_patient_state.dart';

class FindPatientCubit extends Cubit<FindPatientState> {
  FindPatientCubit(this._findPatientRepository) : super(FindPatientInitial());

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  final FindPatientRepository _findPatientRepository;

  Future<void> findPatients(String query, int searchKey, String accessToken,
      [bool resetPage = true]) async {
    final List<SearchPatient> inList = [];
    bool isComplete = false;

    if (state is FindPatientLoading) return;
    if (state is FindPatientLoaded) {
      if ((state as FindPatientLoaded).patients.isNotEmpty) {
        inList.addAll((state as FindPatientLoaded).patients);
      }
      if ((state as FindPatientLoaded).isComplete) {
        isComplete = (state as FindPatientLoaded).isComplete;
      }
    }
    if (state is FindPatientInitial) {
      emit(FindPatientLoading());
    }

    if (!isComplete) {
      if (_isFetching) return;
      _isFetching = true;
      try {
        //emit(FindPatientLoading());

        final patients = await _findPatientRepository.searchPatients(
            query, searchKey, resetPage, accessToken);

        patients.fold(
            (l) => emit(FindPatientFail(errorSMS: "Error del servidor")),
            (r) => r.listSearchPatient.isNotEmpty
                ? emit(resetPage
                    ? FindPatientLoaded(patients: r.listSearchPatient)
                    : FindPatientLoaded(patients: inList).copyWith(
                        patients: r.listSearchPatient,
                        isComplete: r.isComplete))
                : emit(FindPatientLoadedButEmpty(
                    sms: "Parece que no tienes casos pendientes")));
      } catch (e) {
        print('Error: $e');
        emit(FindPatientFail(errorSMS: "Error cargando los datos"));
      } finally {
        _isFetching = false;
      }
    }
  }

  Future<void> refreshPatients(query, searchKey, accessToken) async {
    emit(FindPatientInitial());

    await findPatients(query, searchKey, accessToken);
  }
}
