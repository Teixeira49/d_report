import 'follows_in_case.dart';

class FollowCaseResultsDTO{

  FollowCaseResultsDTO(
      {
        required this.followsList,
        required this.followsIsComplete,
        required this.followsCountTotal,
      }
      );

  List<FollowCase> followsList;
  bool followsIsComplete;
  int followsCountTotal;
}