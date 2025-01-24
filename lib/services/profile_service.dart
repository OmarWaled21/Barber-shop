import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileService {
  static final ProfileService instance = ProfileService._();

  ProfileService._();

  /// Fetches user data from Firestore.
  Future<Map<String, dynamic>> getUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User not logged in");
    }

    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (!userDoc.exists) {
      throw Exception("User document does not exist");
    }

    return userDoc.data() as Map<String, dynamic>;
  }

  /// Saves updated user data to Firestore.
  Future<void> saveUserData({
    required String name,
    required String phone,
    required String location,
  }) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User not logged in");
    }

    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'name': name,
      'phone': phone,
      'location': location,
    });
  }
}
