import 'package:barber_shop/models/all_booking_model.dart';
import 'package:barber_shop/models/service_item_model.dart';
import 'package:barber_shop/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeServiceItemsService {
  // Private constructor
  HomeServiceItemsService._();

  // Static variable to hold the single instance
  static final HomeServiceItemsService _instance = HomeServiceItemsService._();

  // Getter to access the single instance
  static HomeServiceItemsService get instance => _instance;

  AllBookingModel? currentBooking; // Store the booking locally

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
    double? totalPrice,
    List<ServiceItemModel>? selectedServices,
    String? selectedDate,
    String? selectedTime,
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

      // Get the current month and year
      final currentMonth = DateTime.now().month.toString().padLeft(2, '0');
      final currentYear = DateTime.now().year.toString();

      // If currentBooking is null, create a new one, otherwise update existing fields
      if (currentBooking == null) {
        currentBooking = AllBookingModel(
          name: userModel.name,
          branchGovern: userModel.branchGovern ?? 'Default Governance',
          branchLocation: userModel.branchLocation ?? 'Default Location',
          totalPrice: totalPrice?.toString() ?? '0.0', // Default to 0.0 if null
          serviceItems: selectedServices ?? [], // Default to empty list if null
          date:
              '${selectedDate ?? DateTime.now().day.toString()}/$currentMonth/$currentYear',
          time: selectedTime,
        );
      } else {
        // Update only the date and time if currentBooking exists
        currentBooking!.date =
            '${selectedDate ?? DateTime.now().day.toString()}/$currentMonth/$currentYear';
        currentBooking!.time = selectedTime ?? currentBooking!.time;

        // You can also update serviceItems and totalPrice if they were passed
        if (selectedServices != null) {
          currentBooking!.serviceItems = selectedServices;
        }
        if (totalPrice != null) {
          currentBooking!.totalPrice = totalPrice.toString();
        }
      }

      debugPrint("Booking history updated successfully.");
    } catch (e) {
      debugPrint("Error updating booking history: $e");
    }
  }
}
