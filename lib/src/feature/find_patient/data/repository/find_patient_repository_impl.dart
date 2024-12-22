import 'package:d_report/src/core/network/error/failures.dart';
import 'package:d_report/src/shared/domain/entities/case_report.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/patient.dart';
import '../../domain/repository/find_patient_reporitory.dart';
import '../datasource/remote/find_patient_remote_datasource.dart';

class FindPatientRepositoryImpl implements FindPatientRepository {

  final FindPatientRemoteDataSource findPatientRemoteDataSource;

  FindPatientRepositoryImpl({
    required this.findPatientRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<SearchPatient>>> searchPatients(String query, int searchKey, String accessToken) async {
    try {
      final List<SearchPatient> resp = await findPatientRemoteDataSource.searchPatients(query, searchKey, accessToken);
      return Right(resp);
    } on DioException {
      return Left(ServerFailure("Fallo en conexion al servidor"));
    }
  }
}