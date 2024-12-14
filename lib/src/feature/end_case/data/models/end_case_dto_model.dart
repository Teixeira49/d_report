// TODO creo esto no deberia existir pero me facilitara la existencia un poco

import 'package:d_report/src/feature/end_case/domain/entities/end_case_dto.dart';

class EndCaseDTOModel extends EndCaseDTO {
  EndCaseDTOModel(
      {required super.encPatId,
      required super.encCasId,
      required super.encEndReason,});

  factory EndCaseDTOModel.fromJson(json) {
    return EndCaseDTOModel(
        encPatId: json['patId'],
        encCasId: json['casId'],
        encEndReason: json['casEndReason']);
  }

  Map<String, dynamic> toJson() {
    return {
      'encPatId': encPatId,
      'encCasId': encCasId,
      'encEndReason': encEndReason,
    };
  }

  factory EndCaseDTOModel.fromEntity(EndCaseDTO endCase) {
    return EndCaseDTOModel(
      encPatId: endCase.encPatId,
      encCasId: endCase.encCasId,
      encEndReason: endCase.encEndReason,
    );
  }
}
