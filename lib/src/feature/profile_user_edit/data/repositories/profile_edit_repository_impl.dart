

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/error/failures.dart';
import '../../domain/entities/doctor.dart';
import '../../domain/repositories/profile_edit_repository.dart';
import '../datasource/remote/profile_edit_remote_data_source.dart';

class ProfileEditRepositoryImpl implements ProfileEditRepository {

  final ProfileEditRemoteDataSource profileEditRemoteDataSource;

  ProfileEditRepositoryImpl({
    required this.profileEditRemoteDataSource,
  });

  @override
  Future<Either<Failure, Doctor>> putDoctorProfile(int docId, String accessToken) async {
    try {
      final Doctor resp = await profileEditRemoteDataSource.putDoctorProfile(docId, accessToken);
      return Right(resp);
    } on DioException {
      return Left(ServerFailure("Fallo en conexion al servidor"));
    }
  }

}