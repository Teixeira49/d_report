import '../../data/models/case_model.dart';
import '../entities/case_report.dart';


class CreateInstanceCaseReportUseCase {

  CreateInstanceCaseReportUseCase();

  CaseReport call(dynamic caseJson) {
    return CaseReportModel.fromJson(caseJson);
  }
}