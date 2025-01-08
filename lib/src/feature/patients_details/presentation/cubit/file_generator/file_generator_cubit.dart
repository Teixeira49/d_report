import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants/fields_constants.dart';

import '../../../../../shared/domain/entities/auth_user.dart';
import '../../../../../shared/domain/entities/user.dart';

import '../../../domain/entities/patient.dart';
import '../../../domain/entities/case_report.dart';
import '../../../domain/entities/follows_in_case.dart';

import '../../../domain/usecases/download_record.dart';
import '../../../domain/usecases/get_downloadable_follows.dart';

import 'file_generator_state.dart';

class FileGeneratorCubit extends Cubit<FileGeneratorState> {
  final DownloadPatientRecordUseCase downloadPatientRecordUseCase;
  final GetDownloadableFollowsUseCase getDownloadableFollowsUseCase;

  FileGeneratorCubit(
      this.downloadPatientRecordUseCase, this.getDownloadableFollowsUseCase)
      : super(FileGeneratorInitial());

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  Future<void> downloadFile(
      Patient patient, CaseReport caseReport, User docUser, AuthUser authUser,
      [bool addDoctorSign = false,
      bool addPatDetails = false,
      String? addFollows = 'Ninguno']) async {
    try {
      //final data = await useCase.call(casId);

      emit(FileGeneratorLoading());

      List<FollowCase> followCases = [];

      if (addFollows != addCaseFollowType[0]) {
        var follows = await getDownloadableFollowsUseCase.call(
            caseReport.casId,
            (addFollows == addCaseFollowType[1] ? docUser.userProfileId : null),
            authUser.accessToken);
        follows.fold(
          (l) => null,
          (r) => followCases.addAll(r),
        );
      }

      print("cubit $followCases");

      final data = await downloadPatientRecordUseCase.call(patient, caseReport,
          docUser.userName, (followCases.isNotEmpty ? followCases : null), addDoctorSign, addPatDetails, addFollows ?? 'Ninguno');

      data.fold((l) => emit(FileGeneratorFail(errorSMS: l.message)),
          (r) => emit(FileGeneratorLoaded(pdf: r)));
    } catch (e) {
      print('Error: $e');
      emit(FileGeneratorFail(errorSMS: "Error cargando los datos"));
    } finally {
      _isFetching = false;
    }
  }
}
