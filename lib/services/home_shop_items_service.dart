import 'package:barber_shop/models/shop_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeShopItemsService {
  Future<List<ShopItemModel>> getShoptems() async {
    try {
      // Step 1: Get the currently logged-in user
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception("User not logged in");
      }

      // Step 2: Fetch the user's document from Firestore
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      // Step 3: Retrieve the branch ID from the user's document
      final branchId = userDoc['branch_id'] as String?;

      if (branchId == null) {
        throw Exception("Branch ID not found for the user");
      }

      // Step 4: Fetch service items for the branch
      final querySnapshot = await FirebaseFirestore.instance
          .collection('location')
          .doc(branchId) // Document for the specific branch
          .collection('shop') // Sub-collection for services
          .get();

      // Map Firestore data to ServiceItemModel
      final shopItems = querySnapshot.docs.map((doc) {
        return ShopItemModel.fromJson(doc.data());
      }).toList();

      return shopItems;
    } catch (e) {
      debugPrint("Error fetching service items: $e");
      return [];
    }
  }
}
