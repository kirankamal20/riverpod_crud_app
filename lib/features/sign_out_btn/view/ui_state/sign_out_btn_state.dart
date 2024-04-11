sealed class SignOutBtnState {}

class InitialSignOutBtnState extends SignOutBtnState {}

class SignOutBtnLoadingState extends SignOutBtnState {}

class SignOutBtnSuccessState extends SignOutBtnState {}

class SignOutBtnErrorState extends SignOutBtnState {
  final String? errorMessage;

  SignOutBtnErrorState(this.errorMessage);
}
