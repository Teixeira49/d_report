import '../../domain/entities/follows_in_case_results_dto.dart';

class FollowCaseResultsDTOModel extends FollowCaseResultsDTO {

  FollowCaseResultsDTOModel({
    required  super .followsList,
    required  super .followsIsComplete,
    required  super .followsCountTotal,
  });

  factory FollowCaseResultsDTOModel.fromMixedJsonAndList(json, follows) {
    return FollowCaseResultsDTOModel(
      followsList: follows,
      followsIsComplete: json['last'],
      followsCountTotal: json['totalElements'],
    );
  }
}