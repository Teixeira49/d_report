import 'package:bloc/bloc.dart';
import 'package:d_report/src/feature/new_follow/presentation/cubit/upload_follow/upload_follow_state.dart';
import '../../../domain/repository/new_follow_repository.dart';

class UploadFollowCubit extends Cubit<UploadFollowState> {

  final FollowCaseRepositoryImpl _repositoryImpl;

  UploadFollowCubit(this._repositoryImpl) : super(UploadFollowInitial());

  Future<void> postUploadFollowData(Map<String, dynamic> data, String accessToken) async {
    try {
      emit(UploadFollowLoading());
      await _repositoryImpl.postFollowCaseData(data, accessToken);
      emit(UploadFollowPosted());
    } catch (e) {
      emit(UploadFollowError('Error al subir los datos del paciente'));
    }
  }
}