sealed class RegisterState {}

class InitialRegisterState extends RegisterState {
  InitialRegisterState();
}

class RegisterLoadingState extends RegisterState {
  RegisterLoadingState();
}

class RegistrationSuccessState extends RegisterState {
  RegistrationSuccessState();
}

class RegistrationErrorState extends RegisterState {
  final String? errorMessage;
  RegistrationErrorState(this.errorMessage);
}
