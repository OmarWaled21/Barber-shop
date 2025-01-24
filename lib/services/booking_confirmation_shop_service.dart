import 'dart:developer';

import 'package:barber_shop/helper/navigator_extention.dart';
import 'package:barber_shop/services/home_shop_items_service.dart';
import 'package:barber_shop/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

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

      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Items confirmed succefully thanks for using our app',
        onConfirmBtnTap: () => context.pushAndRemoveUntil(const HomeView()),
      );
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
      );
      log(e.toString());
    }
  }
}
