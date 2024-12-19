

abstract class RegisterButtonState {}

class RegisterButtonInitial extends RegisterButtonState {}

class RegisterButtonLoading extends RegisterButtonState {}

class RegisterButtonLoaded extends RegisterButtonState {
  final String registerButtonUser;
  RegisterButtonLoaded(this.registerButtonUser);
}

class RegisterButtonError extends RegisterButtonState {
  final String errorSMS;
  RegisterButtonError(this.errorSMS);
}