import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'branch_state.dart';

class BranchCubit extends Cubit<BranchState> {
  BranchCubit() : super(BranchInitial());

  Future<void> checkUserBranch() async {
    emit(BranchLoading());
  }
}
