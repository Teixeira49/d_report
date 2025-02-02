import 'package:d_report/src/feature/patient_case_doctors/domain/entities/assigned_doctor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/fetch_doctors.dart';
import 'view_doctors_state.dart';

class ViewDoctorsCubit extends Cubit<ViewDoctorsState> {
  final FetchDoctorsUseCase _fetchDoctorsUseCase;

  ViewDoctorsCubit(
    this._fetchDoctorsUseCase,
  ) : super(ViewDoctorsInitial());

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  Future<void> getDoctors(int casId, String accessToken,
      [bool resetPage = true]) async {
    final List<AssignedDoctor> inList = [];
    bool isComplete = false;

    if (state is ViewDoctorsLoading) return;
    if (state is ViewDoctorsLoaded) {
      if ((state as ViewDoctorsLoaded).listAssignedDoctors.isNotEmpty) {
        inList.addAll((state as ViewDoctorsLoaded).listAssignedDoctors);
      }
      if ((state as ViewDoctorsLoaded).isCompleteAssignedDoctors) {
        isComplete = (state as ViewDoctorsLoaded).isCompleteAssignedDoctors;
      }
    }
    if (state is ViewDoctorsInitial) {
      emit(ViewDoctorsLoading());
    }

    if (!isComplete) {
      if (_isFetching) return;
      _isFetching = true;

      try {
        emit(ViewDoctorsLoading());
        final data = await _fetchDoctorsUseCase.call(casId, resetPage, accessToken);

        data.fold(
            (l) => emit(ViewDoctorsFail(errorSMS: l.message)),
            (r) => r.countAssignedDoctors > 0
                ? emit(resetPage
                    ? ViewDoctorsLoaded(
                        listAssignedDoctors: r.assignedDoctors,
                        countTotalAssignedDoctors: r.countAssignedDoctors)
                    : ViewDoctorsLoaded(
                            listAssignedDoctors: inList,
                            countTotalAssignedDoctors: r.countAssignedDoctors)
                        .copyWith(
                            doctors: r.assignedDoctors,
                            isComplete: r.isCompleteAssignedDoctors))
                : emit(ViewDoctorsWithoutUpdate(
                    errorSMS: 'Este paciente no posee casos')));
      } catch (e) {
        print('Error: $e');
        if ((state is ViewDoctorsLoaded)) {
          emit(ViewDoctorsLoaded(
              listAssignedDoctors:
                  (state as ViewDoctorsLoaded).listAssignedDoctors,
              countTotalAssignedDoctors:
                  (state as ViewDoctorsLoaded).countTotalAssignedDoctors));
        } else {
          emit(ViewDoctorsFail(errorSMS: e.toString()));
        }
      } finally {
        _isFetching = false;
      }
    }
  }
}
