
import 'package:d_report/src/shared/data/model/view_details_status.dart';

import 'patient.dart';
import 'case_report.dart';

class CompleteCaseDTO{

  CompleteCaseDTO(
    {
      required this.comPatient,
      required this.comCaseReport,
      required this.viewDetailsStatus,
    }
  );

  Patient comPatient;
  CaseReport comCaseReport;
  ViewDetailsStatus viewDetailsStatus;
}