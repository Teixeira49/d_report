import 'package:d_report/src/core/network/error/failures.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../shared/domain/entities/doctor.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasource/remote/profile_remote_data_source.dart';


class ProfileRepositoryImpl implements ProfileRepository {

  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepositoryImpl({
    required this.profileRemoteDataSource,
  });

  @override
  Future<Either<Failure, DoctorProfile>> getDoctorProfileById(int docId, String accessToken) async {
    try {
      final DoctorProfile resp = await profileRemoteDataSource.getDoctorById(docId, accessToken);
      return Right(resp);
    } on DioException {
      return Left(ServerFailure("Fallo en conexion al servidor"));
    }
  }

}