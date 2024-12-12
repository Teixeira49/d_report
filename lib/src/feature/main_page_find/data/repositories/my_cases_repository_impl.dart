import 'package:d_report/src/core/network/error/failures.dart';


import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:flutter/src/widgets/navigator.dart';

import '../../domain/entities/case_simple.dart';
import '../../domain/repositories/my_cases_repository.dart';
import '../datasources/my_cases_remote_data_sources.dart';


class MyCasesRepositoryImpl implements MyCasesRepository {

  final MyCasesRemoteDataSource myCasesRemoteDataSource;
  //final MyCasesLocalDataSource myCasesLocalDataSource;

  MyCasesRepositoryImpl({
    required this.myCasesRemoteDataSource,
    //required this.myCasesLocalDataSource,
  });

  @override
  Future<Either<Failure, List<CaseSimple>>> getMyCasesById(int docId, String accessToken) async {
    try {
      final List<CaseSimple> resp = await myCasesRemoteDataSource.getMyCases(docId, accessToken);
      return Right(resp);
    } on DioException {
      return Left(ServerFailure("Fallo en conexion al servidor"));
    }
  }

  @override
  Future<Either<Failure, List<CaseSimple>>> getSearchInMyCases(String patName) {
    // TODO: implement getSearchInMyCases
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> saveLocalMyCase(Page<CaseSimple> caseSimple) {
    // TODO: implement saveLocalMyCase
    throw UnimplementedError();
  }
  
}