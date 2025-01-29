import 'package:d_report/src/core/network/error/failures.dart';
import 'package:d_report/src/shared/domain/entities/case_report.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/add_case.dart';
import '../../domain/entities/patient.dart';
import '../../domain/repository/new_case_repository.dart';
import '../datasource/remote/new_case_remote_datasource.dart';

class NewPatientCaseRepositoryImpl implements NewCaseRepository {

  final NewPatientCaseRemoteDataSource newPatientCaseRemoteDataSource;

  NewPatientCaseRepositoryImpl({
    required this.newPatientCaseRemoteDataSource,
  });

  @override
  Future<Either<Failure, CaseReport>> createCaseByNewPatient(Patient patData, NewCaseReport casData, String accessToken) async {
    try {
      print('paciente $patData');
      print('caso $casData');
      final CaseReport resp = await newPatientCaseRemoteDataSource.createCaseByNewPatient(patData, casData, accessToken);
      return Right(resp);
    } on DioException {
      return Left(ServerFailure("Fallo en conexion al servidor"));
    }
  }

  @override
  Future<Either<Failure, CaseReport>> createCaseByOldPatient(int patData, NewCaseReport casData, String accessToken) async {
    try {
      print('paciente $patData');
      print('caso $casData');
      final CaseReport resp = await newPatientCaseRemoteDataSource.createCaseByOldPatient(patData, casData, accessToken);
      return Right(resp);
    } on DioException {
      return Left(ServerFailure("Fallo en conexion al servidor"));
    }
  }
}