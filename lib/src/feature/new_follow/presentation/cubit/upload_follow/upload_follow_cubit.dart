import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:d_report/src/feature/new_follow/presentation/cubit/upload_follow/upload_follow_state.dart';
import '../../../domain/use_cases/create_follow.dart';

class UploadFollowCubit extends Cubit<UploadFollowState> {

  final CreateFollowUseCase _createFollowUseCase;

  UploadFollowCubit(this._createFollowUseCase) : super(UploadFollowInitial());

  Future<void> postUploadFollowData(Map<String, dynamic> input, String accessToken) async {

    try {

      emit(UploadFollowLoading());

      final data = await _createFollowUseCase.call(input, accessToken);

      data.fold(
              (l) => emit(UploadFollowError(l.message)),
              (r) => emit(UploadFollowPosted(r))
      );

    } catch (e) {
      emit(UploadFollowError('Error al subir los datos del paciente'));
    }
  }
}