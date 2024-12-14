import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/follows_in_case.dart';

abstract class FollowRepository {

  Future<Either<Failure, List<FollowCase>>> getCaseFollowsByCase(int casId, String accessToken);

}