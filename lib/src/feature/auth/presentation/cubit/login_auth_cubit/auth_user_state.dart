import '../../../../../shared/domain/entities/auth_user.dart';
import '../../../../../shared/domain/entities/user.dart';


abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  final AuthUser authUser;
  final User user;
  AuthLoaded(this.authUser, this.user);
}

class AuthPosted extends AuthState {}

class AuthError extends AuthState {
  final String errorSMS;
  AuthError(this.errorSMS);
}