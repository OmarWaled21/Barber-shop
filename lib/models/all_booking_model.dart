import 'dart:developer';

import 'package:barber_shop/models/service_item_model.dart';
import 'package:barber_shop/models/shop_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AllBookingModel {
  String? name;
  List<ShopItemModel>? shopItems;
  List<ServiceItemModel>? serviceItems;
  String? totalPrice;
  String? branchGovern;
  String? branchLocation;
  String? date;
  String? time;

  AllBookingModel({
    this.name,
    this.serviceItems,
    this.shopItems,
    this.totalPrice,
    this.branchGovern,
    this.branchLocation,
    this.date,
    this.time,
  });

  // Fetch user data from Firestore
  Future<void> fetchUserData() async {
    try {
      final String userId = FirebaseAuth.instance.currentUser!.uid;

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;

        name = userData['name'] ?? 'Default Name';
        branchGovern = userData['branch_govern'] ?? 'Default Governance';
        branchLocation = userData['branch_location'] ?? 'Default Location';
      } else {
        throw Exception('User data not found');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  // Save booking to Firestore only if confirmed
  Future<void> saveBookingToFirestore() async {
    try {
      final String userId = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('history')
          .add({
        'userId': userId,
        'name': name,
        'shopItems': shopItems
            ?.map((item) => item.toJson())
            .toList(), // Assuming ShopItemModel has toMap
        'serviceItems': serviceItems
            ?.map((item) => item.toJson())
            .toList(), // Assuming ServiceItemModel has toMap
        'totalPrice': totalPrice,
        'branchGovern': branchGovern,
        'branchLocation': branchLocation,
        'date': date,
        'time': time,
        'createdAt': FieldValue.serverTimestamp(),
      });

      log('Booking saved successfully.');
    } catch (e) {
      log('Error saving booking: $e');
    }
  }
}
