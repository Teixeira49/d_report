
import 'package:d_report/src/feature/patients_details/domain/entities/case_report.dart';
import 'package:d_report/src/feature/patients_details/domain/entities/patient.dart';

class CompleteCaseDTO{

  CompleteCaseDTO(
    {
      required this.comPatient,
      required this.comCaseReport,
    }
  );

  Patient comPatient;
  CaseReport comCaseReport;
}