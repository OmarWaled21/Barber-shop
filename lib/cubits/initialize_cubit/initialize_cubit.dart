import 'package:barber_shop/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'initialize_state.dart';

class InitializeCubit extends Cubit<InitializeState> {
  InitializeCubit() : super(InitializeInitial());

  late UserModel userInfo;

  Future<void> checkUserAssigned() async {
    emit(InitializeLoading());
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(InitializeNotAssigned());
        return;
      }
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!userDoc.exists || userDoc.data() == null) {
        emit(InitializeNotAssigned());
        return;
      }

      // Convert Firestore document to a map
      final userData = userDoc.data() as Map<String, dynamic>?;

      // Create UserModel instance from Firestore data
      final UserModel userModel = UserModel.fromJson(userData);

      userInfo = userModel;

      // Emit the BranchAssigned state with the UserModel
      emit(InitializeAssigned(userModel: userModel));
    } catch (e) {
      emit(Initializefailure(errMsg: e.toString()));
    }
  }
}
