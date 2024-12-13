import 'package:bloc/bloc.dart';
import 'package:d_report/src/feature/profile_user/data/repositories/profile_repository_impl.dart';
import 'package:d_report/src/feature/profile_user/presentation/cubit/profile_data/profile_data_state.dart';

class ProfileDataCubit extends Cubit<ProfileDataState> {
  ProfileDataCubit({required ProfileRepositoryImpl profileRepositoryImpl})
      : _profileRepositoryImpl = profileRepositoryImpl,
        super(ProfileDataInitial());

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  //final GetPatientDataUseCase useCase;

  final ProfileRepositoryImpl _profileRepositoryImpl;

  Future<void> getDoctorProfile(int docId, String accessToken) async {

    try {
      emit(ProfileDataLoading());
      final data =
          await _profileRepositoryImpl.getDoctorProfileById(docId, accessToken);

      data.fold(
          (l) => emit(ProfileDataFail(errorSMS: "Error cargando los datos")),
          (r) => emit(ProfileDataLoaded(doctor: r)));
    } catch (e) {
      emit(ProfileDataFail(errorSMS: "Error cargando los datos"));
    } finally {
      _isFetching = false;
    }
  }

  Future<void> refreshProfile(casId, accessToken) async {
    emit(ProfileDataInitial());
    await getDoctorProfile(casId, accessToken);
  }
}
