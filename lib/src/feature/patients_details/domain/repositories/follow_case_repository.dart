import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/follows_detailed_case.dart';
import '../entities/follows_in_case_results_dto.dart';

abstract class FollowRepository {

  Future<Either<Failure, FollowCaseResultsDTO>> getCaseFollowsByCase(int casId, bool resetPage, String accessToken);

  Future<Either<Failure, List<FollowDetailedCase>>> getAllCaseFollowsByCase(int casId, int? docId, String accessToken);
}