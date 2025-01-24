import 'dart:developer';

import 'package:barber_shop/services/home_service_items_service.dart';
import 'package:barber_shop/services/time_day_service.dart';
import 'package:flutter/material.dart';

extension BookingConfirmationService on HomeServiceItemsService {
  Future<void> confirmBooking(BuildContext context) async {
    try {
      // Check if the booking exists locally
      if (currentBooking == null) {
        throw Exception("No booking prepared to confirm.");
      }

      // Save the booking to Firestore
      await currentBooking!.saveBookingToFirestore();

      // Clear the currentBooking data after saving
      currentBooking = null;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Booking confirmed and saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to confirm booking: $e'),
          backgroundColor: Colors.red,
        ),
      );
      log(e.toString());
    }
  }

  Future<void> changeAvailablity() async {
    try {
      // Ensure currentBooking is not null
      if (currentBooking == null || currentBooking!.date == null) {
        throw Exception("Booking or booking date is null");
      }

      // Parse the date string (assuming the format is 'selectedDate/currentMonth/currentYear')
      final dateParts = currentBooking!.date!.split('/');
      final day = int.tryParse(dateParts[0]); // Extract the day from the date

      if (day == null) {
        throw Exception("Invalid day in booking date");
      }

      // Call the updateTimeSlotAvailability with the day, time, and availability status
      await TimeDayService().updateTimeSlotAvailability(
        day, // Pass the day as an integer
        currentBooking!.time!,
        false, // Set availability to false
      );
    } catch (e) {
      debugPrint("Error changing availability: $e");
    }
  }
}
