import 'dart:developer';

import 'package:barber_shop/services/home_service_items_service.dart';
import 'package:flutter/material.dart';

extension ShopConfirmationService on HomeServiceItemsService {
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
}
