
import 'package:d_report/src/feature/patients_details/data/models/case_model.dart';
import 'package:d_report/src/feature/patients_details/domain/entities/complete_report_dto.dart';
import 'package:d_report/src/feature/patients_details/domain/entities/patient.dart';

import '../datasource/remote/all_case_remote_data_source.dart';
import '../models/patient_model.dart';

//abstract class Repository {
//  Future<Patient> getPatientData(int casId);
//}

class PatientRepositoryImpl { //implements Repository {
  const PatientRepositoryImpl(this._patientDataRemoteDataSource);

  final AllCaseRemoteDataSource _patientDataRemoteDataSource;

  Future<CompleteCaseDTO> getPatientCaseData(casId, accessToken) async {
    final patientCaseData = await _patientDataRemoteDataSource.getPatientData(casId, accessToken);
    return CompleteCaseDTO(
      comPatient: PatientModel.fromEntity(patientCaseData["pat"]),
      comCaseReport: CaseReportModel.fromEntity(patientCaseData["cas"])
    );
  }
}