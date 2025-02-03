import 'package:d_report/src/core/network/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/patient.dart';
import '../../domain/repository/new_patient_case_repository.dart';
import '../datasource/remote/new_patient_case_remote_datasource.dart';

class NewPatientCaseRepositoryImpl implements NewPatientCaseRepository {

  final NewPatientCaseRemoteDataSource newPatientCaseRemoteDataSource;

  NewPatientCaseRepositoryImpl({
    required this.newPatientCaseRemoteDataSource,
  });

  @override
  Future<Either<Failure, Patient>> createPatient(Map<String, dynamic> patientData, String accessToken) async {
    try {
      final Patient resp = await newPatientCaseRemoteDataSource.createPatient(patientData, accessToken);
      return Right(resp);
    } on DioException {
      return Left(ServerFailure("Fallo en conexion al servidor"));
    }
  }

  @override
  Future<Either<Failure, String>> checkIfPatientExist(String patName, String patLastName, int patGuardianDni, String accessToken, [int? patDni]) async {
    try {
      final String resp = await newPatientCaseRemoteDataSource.checkIfPatientExist(patName, patLastName, patGuardianDni, accessToken, patDni);
      return Right(resp);
    } on DioException {
      return Left(ServerFailure("Fallo en conexion al servidor"));
    }
  }
}