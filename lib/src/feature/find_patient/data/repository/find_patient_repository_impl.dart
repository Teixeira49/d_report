import 'package:d_report/src/core/network/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/search_patients_dto.dart';
import '../../domain/repository/find_patient_reporitory.dart';
import '../datasource/remote/find_patient_remote_datasource.dart';

class FindPatientRepositoryImpl implements FindPatientRepository {

  final FindPatientRemoteDataSource findPatientRemoteDataSource;

  FindPatientRepositoryImpl({
    required this.findPatientRemoteDataSource,
  });

  @override
  Future<Either<Failure, PatientsResultsDTO>> searchPatients(String query, int searchKey, bool resetPage, String accessToken) async {
    try {
      final PatientsResultsDTO resp = await findPatientRemoteDataSource.searchPatients(query, searchKey, resetPage, accessToken);
      return Right(resp);
    } on DioException {
      return Left(ServerFailure("Fallo en conexion al servidor"));
    }
  }
}