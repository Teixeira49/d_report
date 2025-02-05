

import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/follow_case.dart';
import '../repository/new_follow_repository.dart';

class CreateFollowUseCase {

  CreateFollowUseCase(this._followCaseRepository);

  final FollowCaseRepository _followCaseRepository;

  Future<Either<Failure, FollowCase>> call(Map<String, dynamic> input, String accessToken) async {
    try {
      var data = await _followCaseRepository.postFollowCaseData(input, accessToken);
      return data.fold(
              (l) => Left(ServerFailure(l.message)),
              (r) => Right(r)
      );
    } catch (e) {
      return Left(LocalProcessFailure(e.toString()));
    }
  }
}