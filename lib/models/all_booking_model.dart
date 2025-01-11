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

  // Method to fetch user-related fields from Firestore
  Future<void> fetchUserData() async {
    try {
      // Get the current user ID
      final String userId = FirebaseAuth.instance.currentUser!.uid;

      // Get the document snapshot of the current user's Firestore record
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        // Retrieve the necessary fields from Firestore
        final userData = userDoc.data() as Map<String, dynamic>;

        // Assign values to the respective fields
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

  //todo: make the history not created till the confirm is true
}
