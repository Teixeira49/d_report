import '../../../../core/utils/constants/fields_constants.dart';
import '../../data/models/case_model.dart';
import '../../data/models/case_report_edit_request_model.dart';
import '../entities/case_report.dart';
import '../entities/case_report_edit_request.dart';

class CompareCasesUseCase {
  CompareCasesUseCase();

  String? call(
      CaseReport originalCase, CaseReportEditRequest updateCase, int part) {
    dynamic originalCaseJson =
        CaseReportModel.fromEntity(originalCase).toJson();
    dynamic updateCaseJson =
        CaseReportEditRequestModel.fromEntity(updateCase).toJson();

    String? error = 'Porfavor, realice modificaciones al caso.';

    List<String> caseRows = checkEqualityUpdateCase[part]!;

    for (var i in caseRows) {
      print('$i ${originalCaseJson[i]} ${updateCaseJson[i]}');
      if (originalCaseJson[i].toLowerCase() !=
          updateCaseJson[i].toLowerCase()) {
        if (updateCaseJson[i] == '') {
          error = 'Porfavor, no deje campos por rellenar.';
        } else {
          error = null;
        }
        break;
      }
    }
    return error;
  }
}
