
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/fetch_doctors.dart';
import 'view_doctors_state.dart';

class ViewDoctorsCubit extends Cubit<ViewDoctorsState> {

  final FetchDoctorsUseCase _fetchDoctorsUseCase;


  ViewDoctorsCubit(this._fetchDoctorsUseCase, )
      : super(ViewDoctorsInitial());

  Future<void> getDoctors(int casId, String accessToken) async {
    try {
      emit(ViewDoctorsLoading());
      final data = await _fetchDoctorsUseCase.call(casId, accessToken);

      data.fold((l) => emit(ViewDoctorsFail(errorSMS: l.message)),
              (r) => emit(ViewDoctorsLoaded(listAssignedDoctors: r)));

    } catch (e) {
      emit(ViewDoctorsFail(errorSMS: e.toString()));
    }
  }
}