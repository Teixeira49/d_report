import 'package:d_report/src/feature/auth_register/domain/entities/create_account_request.dart';
import 'package:d_report/src/feature/profile_user_edit/domain/entities/profile_doctor_request.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/error/failures.dart';
import '../../../../shared/domain/entities/doctor.dart';
import '../../data/datasource/remote/account_remote_data_source.dart';
import '../../data/repositories/register_account_repository.dart';

class AccountRepositoryImpl extends AccountRepository {

  final RegisterAccountRemoteDataSource accountRemoteDataSource;

  AccountRepositoryImpl({required this.accountRemoteDataSource,});

  @override
  Future<Either<Failure, AccountProfileRequest>> registerAccount(AccountProfileRequest profileRequest) async {
    try {
      final AccountProfileRequest resp = await accountRemoteDataSource.registerAccount(profileRequest);
      return Right(resp);
    } on DioException {
      return Left(ServerFailure("Fallo en conexion al servidor"));
    }
  }

  @override
  Future<Either<Failure, String>> validateEmail(String email) async {
    try {
      final String resp = await accountRemoteDataSource.validateEmail(email);
      return Right(resp);
    } on DioException {
      return Left(ServerFailure("Fallo en conexion al servidor"));
    }
  }

}