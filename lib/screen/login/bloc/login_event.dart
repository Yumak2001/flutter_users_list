
abstract class LoginEvent {}

class InitLoginEvent extends LoginEvent {
}

class ValidateLoginEvent extends LoginEvent {
  String username;

  ValidateLoginEvent(this.username);
}