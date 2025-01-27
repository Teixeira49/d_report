import 'package:bloc/bloc.dart';

import '../../../data/repositories/profile_edit_repository_impl.dart';
import 'profile_user_editor_state.dart';

class ProfileDataCubit extends Cubit<ProfileUserEditState> {
  ProfileDataCubit({required ProfileEditRepositoryImpl profileEditRepositoryImpl})
      : _profileEditRepositoryImpl = profileEditRepositoryImpl,
        super(ProfileUserEditInitial());

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  //final GetPatientDataUseCase useCase;

  final ProfileEditRepositoryImpl _profileEditRepositoryImpl;

  Future<void> getDoctorProfile(int docId, String accessToken) async {

    try {
      emit(ProfileUserEditLoading());
      final data =
      await _profileEditRepositoryImpl.putDoctorProfile(docId, accessToken);

      data.fold(
              (l) => emit(ProfileUserEditFail(errorSMS: "Error cargando los datos")),
              (r) => emit(ProfileUserEditLoaded(doctor: r)));
    } catch (e) {
      emit(ProfileUserEditFail(errorSMS: "Error cargando los datos"));
    } finally {
      _isFetching = false;
    }
  }

  Future<void> refreshProfile(casId, accessToken) async {
    emit(ProfileUserEditInitial());
    await getDoctorProfile(casId, accessToken);
  }
}
