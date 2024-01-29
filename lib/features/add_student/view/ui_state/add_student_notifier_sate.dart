sealed class AddStudentState {
  const AddStudentState();
}

class InitialAddStudentState extends AddStudentState {
  const InitialAddStudentState();
}

class LoadingAddStudentState extends AddStudentState {
  final int percentage;
  const LoadingAddStudentState({required this.percentage});
}

class AddStudentStateSuccessState extends AddStudentState {
  const AddStudentStateSuccessState();
}

class AddStudentStateErrorState extends AddStudentState {
  const AddStudentStateErrorState();
}
