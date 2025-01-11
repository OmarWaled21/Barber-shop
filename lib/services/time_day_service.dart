import 'dart:developer';

import 'package:barber_shop/models/time_slots_model.dart';
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
  Future<bool> checkIfTimeSlotExists(String dayFormatted) async {
    try {
      final docRef = _firestore
          .collection('location')
          .doc(await getBranchId())
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
  Future<void> createTimeSlotsForNewDay(int day) async {
    // Get today's date
    final DateTime today = DateTime.now();

    // Format the date using the provided day and current month/year
    final String dayFormatted =
        DateFormat('dd_MM_yyyy').format(DateTime(today.year, today.month, day));

    // Step 1: Check if the document already exists
    final documentExists = await checkIfTimeSlotExists(dayFormatted);

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

    // Create a new document in the 'time_slots' collection with the selected date
    try {
      await _firestore
          .collection('location') // Location collection
          .doc(await getBranchId()) // Branch document
          .collection('time_slots') // Time slots sub-collection
          .doc(dayFormatted) // Document for the selected day (dd_MM_yyyy)
          .set(timeSlots);

      log("Document created for $dayFormatted");
    } catch (e) {
      log("Error creating document: $e");
    }
  }

  // Method to fetch time slots for a given day
  Future<List<TimeSlotModel>> getTimeSlots(int day) async {
    // Format the day to match the format used in createTimeSlotsForNewDay
    final DateTime today = DateTime.now();
    final String dayFormatted =
        DateFormat('dd_MM_yyyy').format(DateTime(today.year, today.month, day));

    try {
      final docRef = _firestore
          .collection('location')
          .doc(await getBranchId())
          .collection('time_slots')
          .doc(dayFormatted);

      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final timeSlotsMap = Map<String, bool>.from(docSnapshot.data() as Map);

        // Sort the Map entries based on time in a 24-hour format
        final sortedEntries = timeSlotsMap.entries.toList()
          ..sort((a, b) {
            // Convert time slots to 24-hour format for comparison
            final timeA =
                a.key.split(' '); // Split to get hour, minute, and AM/PM
            final timeB = b.key.split(' ');

            final hourA = int.parse(timeA[0].split(':')[0]);
            final hourB = int.parse(timeB[0].split(':')[0]);

            final minuteA = int.parse(timeA[0].split(':')[1]);
            final minuteB = int.parse(timeB[0].split(':')[1]);

            final periodA = timeA[1]; // AM/PM
            final periodB = timeB[1];

            // Convert hour to 24-hour format based on AM/PM
            final adjustedHourA =
                (periodA == 'PM' && hourA != 12) ? hourA + 12 : hourA;
            final adjustedHourB =
                (periodB == 'PM' && hourB != 12) ? hourB + 12 : hourB;

            // Compare by 24-hour format time
            if (adjustedHourA != adjustedHourB) {
              return adjustedHourA - adjustedHourB;
            } else {
              return minuteA - minuteB;
            }
          });

        // Convert the sorted entries back into a List of TimeSlotModel
        return sortedEntries
            .map((entry) => TimeSlotModel.fromMap(entry))
            .toList();
      } else {
        log("Document does not exist for $dayFormatted");
        return [];
      }
    } catch (e) {
      log("Error fetching time slots: $e");
      return [];
    }
  }
}
