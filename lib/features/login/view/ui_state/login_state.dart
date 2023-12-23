sealed class LoginState {}

class InitialLoginState extends LoginState {
  InitialLoginState();
}

class LoginLoadingState extends LoginState {
  LoginLoadingState();
}

class LoginSuccessState extends LoginState {
  LoginSuccessState();
}

class LoginErrorState extends LoginState {
  final String? errorMessage;
  LoginErrorState(this.errorMessage);
}
