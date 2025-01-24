import 'package:barber_shop/models/branch_model.dart';
import 'package:barber_shop/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';

class BranchServices {
  Future<List<BranchModel>> getBranches() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('location')
          .orderBy('govern')
          .get();
      final branches = querySnapshot.docs.map((doc) {
        return BranchModel.fromFireStore(doc);
      }).toList();

      return branches;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<void> saveBranch(UserModel userModel) async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({
        'branch_id': userModel.branchID,
        'branch_govern': userModel.branchGovern,
        'branch_location': userModel.branchLocation,
      });
    } catch (e) {
      throw Exception('Failed to save branch: $e');
    }
  }

  void openMapsSheet(BuildContext context, double lat, double lng) async {
    try {
      final coords = Coords(lat, lng);
      const title = "Barber Shop";

      final availableMaps = await MapLauncher.installedMaps;
      final googleMaps = availableMaps.firstWhere(
        (map) => map.mapName.toLowerCase().contains("google"),
      );

      googleMaps.showMarker(
        coords: coords,
        title: title,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
