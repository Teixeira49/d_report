import '../../../../../shared/domain/entities/doctor.dart';

abstract class ProfileLocalDataState {
  ProfileLocalDataState copyWith({String newTitle, DoctorProfile newDoctor});

  String getLocalTitle();

  DoctorProfile? getLocalDoc();
}

class DoctorEditorLocalData extends ProfileLocalDataState {
  final String title;
  final DoctorProfile? doctor;

  DoctorEditorLocalData({this.title = '', this.doctor});

  @override
  DoctorEditorLocalData copyWith({String? newTitle, DoctorProfile? newDoctor}) {
    return DoctorEditorLocalData(
        title: newTitle ?? title, doctor: newDoctor ?? doctor);
  }

  @override
  String getLocalTitle() {
    return title;
  }

  @override
  DoctorProfile? getLocalDoc() {
    return doctor;
  }
}
