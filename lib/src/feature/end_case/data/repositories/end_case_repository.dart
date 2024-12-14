import 'package:d_report/src/core/network/error/failures.dart';

import 'package:d_report/src/feature/end_case/domain/entities/end_case_dto.dart';

import 'package:d_report/src/shared/domain/entities/case_report.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/repositories/end_case_repository.dart';
import '../datasource/remote/end_case_remote_data_source.dart';

class EndCaseRepositoryImpl implements EndCaseRepository {
  const EndCaseRepositoryImpl(this._endCaseRemoteDataSource);

  final EndCaseRemoteDataSource _endCaseRemoteDataSource;

  @override
  Future<Either<Failure, CaseReport>> endSelectedCase(EndCaseDTO endCaseStatus, String accessToken) async {
    try {
      final resp = await _endCaseRemoteDataSource.endCase(endCaseStatus, accessToken);
      return Right(resp);
    } on DioException {
      return Left(ServerFailure("Fallo en conexion al servidor"));
    }
  }
}