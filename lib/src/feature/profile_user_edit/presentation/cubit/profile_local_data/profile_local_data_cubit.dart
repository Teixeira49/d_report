import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/domain/entities/doctor.dart';
import '../../../domain/use_cases/create_instance_doctor_user.dart';
import 'profile_local_data_state.dart';


class ProfileLocalDataCubit extends Cubit<ProfileLocalDataState> {

  final CreateInstanceDoctorUserUseCase _createInstanceDoctorUserUseCase;

  ProfileLocalDataCubit(this._createInstanceDoctorUserUseCase) : super(DoctorEditorLocalData());

  void onModifySelection(String title, dynamic profileJson) {
    DoctorProfile doctor = _createInstanceDoctorUserUseCase.call(profileJson);
    emit(state.copyWith(newTitle: title, newDoctor: doctor));
  }

  void setOriginalDoctor(dynamic doctorJson) {
    DoctorProfile doctor = _createInstanceDoctorUserUseCase.call(doctorJson);
    emit(state.copyWith(newDoctor: doctor));
  }

  String getSelectionTitle() {
    if (state is DoctorEditorLocalData) {
      return state.getLocalTitle();
    }
    return '';
  }

  DoctorProfile? getSelectionPatient() {
    return state.getLocalDoc();
  }

}
