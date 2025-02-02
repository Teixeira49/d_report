import 'package:d_report/src/feature/patients_details/domain/entities/follows_detailed_case.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/error/failures.dart';
import '../../domain/entities/follows_in_case_results_dto.dart';
import '../../domain/repositories/follow_case_repository.dart';
import '../datasource/remote/follow_case_remote_data_source.dart';

class FollowRepositoryImpl implements FollowRepository {
  const FollowRepositoryImpl(this._followCaseRemoteDataSource);

  final FollowCaseRemoteDataSource _followCaseRemoteDataSource;

  @override
  Future<Either<Failure, FollowCaseResultsDTO>> getCaseFollowsByCase(casId, resetPage, accessToken) async {
    try {
      final resp = await _followCaseRemoteDataSource.getCaseFollowsByCase(casId, resetPage, accessToken);
      return Right(resp);
    } on DioException {
      return Left(ServerFailure("Fallo en conexion al servidor"));
    }
  }

  @override
  Future<Either<Failure, List<FollowDetailedCase>>> getAllCaseFollowsByCase(casId, docId, accessToken) async {
    try {
      final resp = await _followCaseRemoteDataSource.getAllCaseFollowsByCase(casId, docId, accessToken);
      return Right(resp);
    } on DioException {
      return Left(ServerFailure("Fallo en conexion al servidor"));
    }
  }
}