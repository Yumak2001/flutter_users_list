abstract class LoginState {}

class InitLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class ValidationErrorLoginState extends LoginState {
  final String errorMsg;

  ValidationErrorLoginState(this.errorMsg);
}

class LoggedInLoginState extends LoginState {}