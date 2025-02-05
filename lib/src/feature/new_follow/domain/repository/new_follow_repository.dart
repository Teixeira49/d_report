import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/follow_case.dart';

abstract class FollowCaseRepository {

  Future<Either<Failure, FollowCase>> postFollowCaseData(Map<String, dynamic> data, String accessToken);
}