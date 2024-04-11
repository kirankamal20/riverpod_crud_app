 sealed class DataSyncButtonState {}

class InitialDataSyncButtonState extends DataSyncButtonState {
  InitialDataSyncButtonState();
}

class DataSyncButtonLoadingState extends DataSyncButtonState {
  DataSyncButtonLoadingState();
}

class DataSyncButtonSuccessState extends DataSyncButtonState {
  DataSyncButtonSuccessState();
}

class DataSyncButtonErrorState extends DataSyncButtonState {
  final String? errorMessage;
  DataSyncButtonErrorState(this.errorMessage);
}
