import 'package:d_report/src/core/network/error/failures.dart';

import 'package:d_report/src/feature/patient_case_doctors/domain/entities/assigned_doctor.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/repository/case_doctors_repository.dart';
import '../datasource/remote/case_doctor_remote_ data_source.dart';

class CaseDoctorRepositoryImpl implements CaseDoctorRepository {
  CaseDoctorRepositoryImpl(this._caseDoctorRemoteDataSource);

  final CaseDoctorRemoteDataSource _caseDoctorRemoteDataSource;

  @override
  Future<Either<Failure, List<AssignedDoctor>>> getDoctorsInCase(
      int casId, String accessToken) async {
    try {
      final doctorsInCaseData = await _caseDoctorRemoteDataSource
          .getDoctorsInCase(casId, accessToken);
      return Right(doctorsInCaseData);
    } on DioException {
      return Left(ServerFailure('Fallo en conexion con el servidor'));
    } catch (e) {
      return Left(OtherFailure('Fallo de Peticion'));
    }
  }
}
