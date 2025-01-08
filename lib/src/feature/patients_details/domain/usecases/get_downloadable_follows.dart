
import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../../data/repository/follow_case_repository.dart';
import '../entities/follows_in_case.dart';

class GetDownloadableFollowsUseCase {

  GetDownloadableFollowsUseCase(this._followRepositoryImpl);

  final FollowRepositoryImpl _followRepositoryImpl;

  Future<Either<Failure, List<FollowCase>>> call(int casId, int? docId, String accessToken) async {

    try {

      final data = await _followRepositoryImpl.getAllCaseFollowsByCase(casId, docId, accessToken);

      print("data $data");

      return data.fold(
              (l) => Left(ServerFailure(l.message)),
              (r) => Right(r)
      );

    } catch (e) {
      return Left(LocalProcessFailure(e.toString()));
    }
  }
}