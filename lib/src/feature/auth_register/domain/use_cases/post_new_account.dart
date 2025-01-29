

import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/create_account_request.dart';
import '../repositories/register_account_repository.dart';

class PostNewAccountUseCase {

  PostNewAccountUseCase(this._repositoryImpl);

  final AccountRepositoryImpl _repositoryImpl;

  Future<Either<Failure, AccountProfileRequest>> call(AccountProfileRequest profileRequest) async {
    try {
      var data = await _repositoryImpl.registerAccount(profileRequest);
      return data.fold((l) => Left(ServerFailure(l.message)), (r) => Right(r));
    } catch (e) {
      return Left(LocalProcessFailure(e.toString()));
    }
  }
}