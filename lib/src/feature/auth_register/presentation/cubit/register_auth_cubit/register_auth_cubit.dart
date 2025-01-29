import 'package:d_report/src/feature/auth_register/domain/entities/create_account_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/check_account.dart';
import '../../../domain/use_cases/post_new_account.dart';
import 'register_auth_state.dart';

class RegisterAuthCubit extends Cubit<RegisterAuthState> {
  final CheckAccountUseCase _accountUseCase;
  final PostNewAccountUseCase _newAccountUseCase;

  RegisterAuthCubit(this._accountUseCase, this._newAccountUseCase)
      : super(RegisterAuthInitial());

  Future<void> validateAccount(
      AccountProfileRequest accountProfileRequest) async {
    try {
      final data = await _newAccountUseCase.call(accountProfileRequest);
      data.fold(
          (l) => emit(RegisterAuthError(errorSMS: l.message)),
          (r) => emit(RegisterAuthPosted(r))
      );
    } catch (e) {
      emit(RegisterAuthError(errorSMS: e.toString()));
    }
  }

  Future<void> validateEmail(String email) async {
    try {
      final data = await _accountUseCase.call(email);
      data.fold(
              (l) => emit(RegisterAuthError(errorSMS: l.message)),
              (r) => emit(RegisterAuthLoaded(r))
      );
    } catch (e) {
      emit(RegisterAuthError(errorSMS: e.toString()));
    }
  }
}
