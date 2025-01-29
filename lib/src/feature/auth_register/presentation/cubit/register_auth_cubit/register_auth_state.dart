
import '../../../domain/entities/create_account_request.dart';

abstract class RegisterAuthState {}

class RegisterAuthInitial extends RegisterAuthState {}

class RegisterAuthLoading extends RegisterAuthState {}

class RegisterAuthLoaded extends RegisterAuthState {
  final String registerAuthUser;
  RegisterAuthLoaded(this.registerAuthUser);
}

class RegisterAuthPosted extends RegisterAuthState {
  final AccountProfileRequest registerAuthUser;
  RegisterAuthPosted(this.registerAuthUser);
}

class RegisterAuthError extends RegisterAuthState {
  final String errorSMS;
  RegisterAuthError({required this.errorSMS});
}

class RegisterTimeoutError extends RegisterAuthState {
  final String errorSMS;
  RegisterTimeoutError({required this.errorSMS});
}