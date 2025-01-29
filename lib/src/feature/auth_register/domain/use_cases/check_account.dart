import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../repositories/register_account_repository.dart';

class CheckAccountUseCase {
  CheckAccountUseCase(this._repositoryImpl);

  final AccountRepositoryImpl _repositoryImpl;

  Future<Either<Failure, String>> call(String email) async {
    try {
      var data = await _repositoryImpl.validateEmail(email);
      return data.fold((l) => Left(ServerFailure(l.message)), (r) => Right(r));
    } catch (e) {
      return Left(LocalProcessFailure(e.toString()));
    }
  }
}
