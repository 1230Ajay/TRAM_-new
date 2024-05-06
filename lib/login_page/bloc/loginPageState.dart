class LoginPageStates{
  final String? error;
  const LoginPageStates({this.error});

  LoginPageStates copyWith({String? error}){
    return LoginPageStates(error: error??this.error);
  }
}