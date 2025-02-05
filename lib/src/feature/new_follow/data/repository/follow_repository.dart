import 'package:d_report/src/core/network/error/failures.dart';


import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/follow_case.dart';
import '../../domain/repository/new_follow_repository.dart';
import '../datasource/remote/new_follow_remote_datasource.dart';

class FollowCaseRepositoryImpl implements FollowCaseRepository {

  const FollowCaseRepositoryImpl(this._followCaseRemoteDataSource);

  final FollowCaseRemoteDataSource _followCaseRemoteDataSource;

  @override
  Future<Either<Failure, FollowCase>> postFollowCaseData(Map<String, dynamic> data, String accessToken) async {
    try {
      final followData = await _followCaseRemoteDataSource.postCaseFollowsByCase(data, accessToken);
      return right(followData);
    } on DioException {
      return left(ServerFailure('Fallo conectando al servidor'));
    } catch (e) {
      return left(LocalProcessFailure(e.toString()));
    }
  }
}