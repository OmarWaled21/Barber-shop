part of 'initialize_cubit.dart';

@immutable
sealed class InitializeState {}

final class InitializeInitial extends InitializeState {}

final class InitializeLoading extends InitializeState {}

final class InitializeAssigned extends InitializeState {
  final UserModel userModel;

  InitializeAssigned({required this.userModel});
}

final class InitializeNotAssigned extends InitializeState {}

final class Initializefailure extends InitializeState {
  final String errMsg;

  Initializefailure({required this.errMsg});
}
