
import '../../domain/entities/case_results_dto.dart';

class CaseResultsDTOModel extends CaseResultsDTO {

  CaseResultsDTOModel({
    required  super .listCasesSimple,
    required  super .isComplete,
    required  super .totalCases,
  });

  factory CaseResultsDTOModel.fromMixedJsonAndList(json, cases) {
    print(json['last']);
    return CaseResultsDTOModel(
        listCasesSimple: cases,
        isComplete: json['last'],
        totalCases: json['totalElements'],
    );
  }

  /*Map<String, dynamic> toJson() {
    return {
      'casId': casId,
      'casActualRoom': casActualRoom,
      'patName': patName,
      'casEndFlag': casEndFlag,
    };
  }

  factory CaseResultsDTOModel.fromEntity(CaseResultsDTO caseSimple) {
    return CaseResultsDTOModel(
      patName: caseSimple.patName,
      casId: caseSimple.casId,
      casActualRoom: caseSimple.casActualRoom,
      casEndFlag: caseSimple.casEndFlag,
    );
  }*/
}