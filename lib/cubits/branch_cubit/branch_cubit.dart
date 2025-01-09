import 'package:barber_shop/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'branch_state.dart';

class BranchCubit extends Cubit<BranchState> {
  BranchCubit() : super(BranchInitial());

  Future<void> checkUserBranch() async {
    emit(BranchLoading());
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(BranchNotAssigned());
        return;
      }
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!userDoc.exists || userDoc.data() == null) {
        emit(BranchNotAssigned());
        return;
      }

      // Convert Firestore document to a map
      final userData = userDoc.data() as Map<String, dynamic>?;

      // Create UserModel instance from Firestore data
      final userModel = UserModel.fromJson(userData);

      // Emit the BranchAssigned state with the UserModel
      emit(BranchAssigned(userModel: userModel));
    } catch (e) {
      emit(Branchfailure(errMsg: e.toString()));
    }
  }
}
