import 'package:barber_shop/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        UserModel newUser = UserModel(name: name, email: email, phone: phone);

        // save to cloud firestore
        await _firestore
            .collection('users')
            .doc(user.uid)
            .set(newUser.toJson());

        return newUser;
      }
    } catch (e) {
      debugPrint('Error during registeriation: $e');
      rethrow;
    }
    return null;
  }
}
