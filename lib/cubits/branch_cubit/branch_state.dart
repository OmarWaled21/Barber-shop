part of 'branch_cubit.dart';

@immutable
sealed class BranchState {}

final class BranchInitial extends BranchState {}

final class BranchLoading extends BranchState {}

final class BranchUnauthorized extends BranchState {}

final class BranchAssigned extends BranchState {}

final class BranchNotAssigned extends BranchState {}

final class Branchfailure extends BranchState {
  final String errMsg;

  Branchfailure({required this.errMsg});
}