class LoginPageEvents{
  const LoginPageEvents();
}

class ErrorEvent extends LoginPageEvents{
  final String error;
  ErrorEvent(this.error);
}