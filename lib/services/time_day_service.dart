import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart'; // For formatting the date

class TimeDayService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> getBranchId() async {
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
    return branchId;
  }

  // Method to check if a time slots document exists for a given day
  Future<bool> checkIfTimeSlotExists(
      String branchId, String dayFormatted) async {
    try {
      final docRef = _firestore
          .collection('location')
          .doc(branchId)
          .collection('time_slots')
          .doc(dayFormatted);

      final docSnapshot = await docRef.get();
      return docSnapshot.exists;
    } catch (e) {
      log("Error checking document existence: $e");
      return false;
    }
  }

  // Method to create a new day's document with time slots
  Future<void> createTimeSlotsForNewDay() async {
    // Get today's date
    final DateTime today = DateTime.now();
    final String dayFormatted = DateFormat('dd_MM_yyyy').format(today);

    // Step 4: Check if the document already exists
    final documentExists =
        await checkIfTimeSlotExists(await getBranchId(), dayFormatted);

    if (documentExists) {
      log("Document already exists for $dayFormatted");
      return;
    }

    // Generate time slots (9 AM to 11 PM)
    final Map<String, bool> timeSlots = {};
    for (int i = 9; i <= 23; i++) {
      final String timeSlot =
          '${i < 12 ? i : i - 12}:00 ${i < 12 ? 'AM' : 'PM'}';
      timeSlots[timeSlot] = true; // Defaulting each time slot to true
    }

    // Create a new document in the 'time_slots' collection with today's date
    try {
      await _firestore
          .collection('location') // Location collection
          .doc(await getBranchId()) // Branch document
          .collection('time_slots') // Time slots sub-collection
          .doc(dayFormatted) // Document for today's date (dd_MM_yyyy)
          .set(timeSlots);

      log("Document created for $dayFormatted");
    } catch (e) {
      log("Error creating document: $e");
    }
  }
}
