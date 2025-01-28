import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/error/failures.dart';
import '../../../../shared/domain/entities/doctor.dart';
import '../../domain/entities/profile_doctor_request.dart';
import '../../domain/repositories/profile_edit_repository.dart';
import '../datasource/remote/profile_edit_remote_data_source.dart';

class ProfileEditRepositoryImpl implements ProfileEditRepository {

  final ProfileEditRemoteDataSource profileEditRemoteDataSource;

  ProfileEditRepositoryImpl({
    required this.profileEditRemoteDataSource,
  });

  @override
  Future<Either<Failure, DoctorProfile>> putDoctorProfile(DoctorProfileRequest profileRequest, String email, String accessToken) async {
    try {
      final DoctorProfile resp = await profileEditRemoteDataSource.putDoctorProfile(profileRequest, email, accessToken);
      return Right(resp);
    } on DioException {
      return Left(ServerFailure("Fallo en conexion al servidor"));
    }
  }
}