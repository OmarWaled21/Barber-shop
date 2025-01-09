import 'package:barber_shop/models/branch_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        return BranchModel.fromJson(doc.data());
      }).toList();

      return branches;
    } catch (e) {
      debugPrint(e.toString());
      return [];
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
