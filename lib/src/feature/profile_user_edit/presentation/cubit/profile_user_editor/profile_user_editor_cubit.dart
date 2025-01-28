import 'package:bloc/bloc.dart';

import '../../../../../shared/domain/entities/doctor.dart';
import '../../../domain/use_cases/compare_profile.dart';
import '../../../domain/use_cases/create_request_instance.dart';
import '../../../domain/use_cases/post_profile_data.dart';
import 'profile_user_editor_state.dart';

class ProfileDataCubit extends Cubit<ProfileUserEditState> {
  ProfileDataCubit(this._compareProfilesUseCase, this._postProfileDataUseCase, this._createInstanceProfileUserRequestUseCase,)
      : super(ProfileUserEditInitial());

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  final CompareProfilesUseCase _compareProfilesUseCase;
  final PostProfileDataUseCase _postProfileDataUseCase;
  final CreateInstanceProfileUserRequestUseCase
      _createInstanceProfileUserRequestUseCase;

  Future<void> putDoctorProfile(DoctorProfile originDoctor,
      DoctorProfile profileRequest, String accessToken) async {
    try {
      emit(ProfileUserEditLoading());

      final check = _compareProfilesUseCase.call(originDoctor, profileRequest);
      if (check != null) {
        emit(ProfileUserEditWithoutUpdate(sms: check));
      } else {
        final profile =
            _createInstanceProfileUserRequestUseCase.call(profileRequest);
        final data = await _postProfileDataUseCase.call(profile, accessToken);
        data.fold(
            (l) =>
                emit(ProfileUserEditFail(errorSMS: "Error cargando los datos")),
            (r) => emit(ProfileUserEditPosted(doctor: r)));
      }
    } catch (e) {
      emit(ProfileUserEditFail(errorSMS: "Error cargando los datos"));
    } finally {
      _isFetching = false;
    }
  }

  Future<void> refreshProfile(DoctorProfile originDoctor,
      DoctorProfile profileRequest, String accessToken) async {
    emit(ProfileUserEditInitial());
    await putDoctorProfile(originDoctor,
        profileRequest, accessToken);
  }
}
