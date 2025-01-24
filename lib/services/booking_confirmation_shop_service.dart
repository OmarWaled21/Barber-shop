import 'dart:developer';

import 'package:barber_shop/helper/show_snack_bar.dart';
import 'package:barber_shop/services/home_shop_items_service.dart';
import 'package:flutter/material.dart';

extension BookingConfirmationService on HomeShopItemsService {
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

      showSnackBar(
          context, "items confirmed and saved successfully!", Colors.green);
    } catch (e) {
      showSnackBar(context, "Failed to confirm booking: $e", Colors.red);
      log(e.toString());
    }
  }
}
