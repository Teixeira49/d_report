import 'package:d_report/src/feature/patient_case_follow_details/domain/entities/downloader_config.dart';
import 'package:d_report/src/feature/patient_case_follow_details/domain/entities/follows_detailed_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/download_record.dart';

import 'file_generator_state.dart';

class FileGeneratorCubit extends Cubit<FileGeneratorState> {
  final DownloadCaseFollowRecordUseCase downloadCaseFollowRecordUseCase;

  FileGeneratorCubit(
      this.downloadCaseFollowRecordUseCase, )
      : super(FileGeneratorInitial());

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  Future<void> downloadFile(FollowDetailedCase followDetailedCase, DownloaderConfig downloaderConfig, String patFullName, [Map<String, dynamic>? patDetails]) async {
    try {

      emit(FileGeneratorLoading());

      final data = await downloadCaseFollowRecordUseCase.call(followDetailedCase, downloaderConfig, patFullName, patDetails);

      data.fold((l) => emit(FileGeneratorFail(errorSMS: l.message)),
              (r) => emit(FileGeneratorLoaded(pdf: r)));

    } catch (e) {
      emit(FileGeneratorFail(errorSMS: "Error cargando los datos"));
    } finally {
      _isFetching = false;
    }
  }
}
