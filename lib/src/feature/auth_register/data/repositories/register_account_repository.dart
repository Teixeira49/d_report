import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../../domain/entities/create_account_request.dart';

abstract class AccountRepository {

  Future<Either<Failure, AccountProfileRequest>> registerAccount(AccountProfileRequest profileRequest);

  Future<Either<Failure, String>> validateEmail(String email);

}