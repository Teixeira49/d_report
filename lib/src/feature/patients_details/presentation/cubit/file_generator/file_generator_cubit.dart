import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/patient.dart';
import '../../../domain/usecases/download_record.dart';
import '../../../domain/entities/case_report.dart';

import 'file_generator_state.dart';

class FileGeneratorCubit extends Cubit<FileGeneratorState> {

  final DownloadPatientRecordUseCase useCase;

  FileGeneratorCubit(this.useCase)
      : super(FileGeneratorInitial());

  bool _isFetching = false;

  bool get isFetching => _isFetching;


  Future<void> downloadFile(Patient patient, CaseReport caseReport, String docName, [bool addDoctorSign = false, bool addPatDetails = false]) async {
    try {
      //final data = await useCase.call(casId);

      emit(FileGeneratorLoading());

      final data = await useCase.call(patient, caseReport, docName, addDoctorSign, addPatDetails);

      data.fold(
              (l) => emit(FileGeneratorFail(errorSMS: l.message)),
              (r) => emit(FileGeneratorLoaded(pdf: r)));
    } catch (e) {
      print('Error: $e');
      emit(FileGeneratorFail(errorSMS: "Error cargando los datos"));
    } finally {
      _isFetching = false;
    }
  }
}