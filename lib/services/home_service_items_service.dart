import 'package:barber_shop/models/service_item_model.dart';
import 'package:barber_shop/models/all_booking_model.dart';
import 'package:barber_shop/models/user_model.dart'; // Import the UserModel
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeServiceItemsService {
  Future<List<ServiceItemModel>> getServiceItems() async {
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
          .collection('service') // Sub-collection for services
          .get();

      // Map Firestore data to ServiceItemModel
      final serviceItems = querySnapshot.docs.map((doc) {
        return ServiceItemModel.fromJson(doc.data());
      }).toList();

      return serviceItems;
    } catch (e) {
      debugPrint("Error fetching service items: $e");
      return [];
    }
  }

  Future<void> saveBookingHistory({
    required double totalPrice,
    required List<ServiceItemModel> selectedServices,
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

      // Create the booking data model using UserModel data
      AllBookingModel booking = AllBookingModel(
        name: userModel.name, // Use the user's name
        branchGovern: userModel.branchGovern ??
            'Default Governance', // Use the user's branch govern
        branchLocation: userModel.branchLocation ??
            'Default Location', // Use the user's branch location
        totalPrice: totalPrice.toString(),
        serviceItems: selectedServices,
      );

      // Get reference to Firestore user's history collection
      final userHistoryRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('history'); // sub-collection for user history

      // Save the booking to Firestore
      await userHistoryRef.add({
        'name': booking.name,
        'branch_govern': booking.branchGovern,
        'branch_location': booking.branchLocation,
        'totalPrice': booking.totalPrice,
        'serviceItems':
            booking.serviceItems?.map((service) => service.toJson()).toList(),
        'createdAt': FieldValue.serverTimestamp(), // Add timestamp
      });
      debugPrint("Booking history saved successfully.");
    } catch (e) {
      debugPrint("Error saving booking history: $e");
    }
  }
}
