import 'package:barber_shop/models/all_booking_model.dart';
import 'package:barber_shop/models/shop_item_model.dart';
import 'package:barber_shop/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeShopItemsService {
  // Private constructor
  HomeShopItemsService._();

  // Static variable to hold the single instance
  static final HomeShopItemsService _instance = HomeShopItemsService._();

  // Getter to access the single instance
  static HomeShopItemsService get instance => _instance;

  AllBookingModel? currentBooking; // Store the booking locally

  Future<List<ShopItemModel>> getShopItems() async {
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

      // Step 4: Fetch shop items for the branch
      final querySnapshot = await FirebaseFirestore.instance
          .collection('location')
          .doc(branchId) // Document for the specific branch
          .collection('shop') // Sub-collection for shop
          .get();

      // Map Firestore data to ShopItemModel
      final shopItems = querySnapshot.docs.map((doc) {
        return ShopItemModel.fromJson(doc.data());
      }).toList();

      return shopItems;
    } catch (e) {
      debugPrint("Error fetching shop items: $e");
      return [];
    }
  }

  Future<void> saveBookingHistory({
    double? totalPrice,
    List<ShopItemModel>? selectedShopItems,
  }) async {
    try {
      // Get the current user ID
      final userId = FirebaseAuth.instance.currentUser!.uid;

      // Fetch the user's details
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      // Map user document data to UserModel
      UserModel userModel =
          UserModel.fromJson(userDoc.data() as Map<String, dynamic>);

      // If currentBooking is null, create a new one, otherwise update existing fields
      if (currentBooking == null) {
        currentBooking = AllBookingModel(
          name: userModel.name,
          branchGovern: userModel.branchGovern ?? 'Default Governance',
          branchLocation: userModel.branchLocation ?? 'Default Location',
          userLocation: userModel.location ?? '',
          shopItems: selectedShopItems,
          totalPrice: totalPrice?.toString() ?? '0.0', // Default to 0.0 if null
        );
      } else {
        // You can also update shopItems and totalPrice if they were passed
        if (selectedShopItems != null) {
          currentBooking!.shopItems = selectedShopItems;
        }
        if (totalPrice != null) {
          currentBooking!.totalPrice = totalPrice.toString();
        }
      }

      debugPrint("Shop booking history updated successfully.");
    } catch (e) {
      debugPrint("Error updating booking history: $e");
    }
  }
}
