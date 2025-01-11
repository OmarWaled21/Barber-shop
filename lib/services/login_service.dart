import 'package:barber_shop/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginService {
  Future<UserModel?> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      // Sign in with FirebaseAuth
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Fetch the logged-in user's data from Firestore
      final User? user = userCredential.user;
      if (user == null) {
        throw Exception("User not found");
      }

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!userDoc.exists || userDoc.data() == null) {
        throw Exception("User data not found");
      }

      // Convert Firestore document to a map
      final userData = userDoc.data() as Map<String, dynamic>?;

      // Create UserModel from Firestore data
      final userModel = UserModel.fromJson(userData);

      return userModel;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }
}
