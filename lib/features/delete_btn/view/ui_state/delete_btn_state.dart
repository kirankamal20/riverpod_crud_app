sealed class DeleteButtonState {}

class InitialDeleteButtonState extends DeleteButtonState {
  InitialDeleteButtonState();
}

class DeleteButtonLoadingState extends DeleteButtonState {
  DeleteButtonLoadingState();
}

class DeleteButtonSuccessState extends DeleteButtonState {
  DeleteButtonSuccessState();
}

class DeleteButtonErrorState extends DeleteButtonState {
  final String? errorMessage;
  DeleteButtonErrorState(this.errorMessage);
}
