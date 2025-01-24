import 'package:barber_shop/services/home_service_items_service.dart';
import 'package:barber_shop/services/home_shop_items_service.dart';
import 'package:barber_shop/views/error_view.dart';
import 'package:barber_shop/widgets/confirm_card_service_items.dart';
import 'package:barber_shop/widgets/confirm_card_shop_items.dart';
import 'package:flutter/material.dart';

class ConfirmCard extends StatelessWidget {
  const ConfirmCard({super.key});

  @override
  Widget build(BuildContext context) {
    final currentServiceBooking =
        HomeServiceItemsService.instance.currentBooking;
    final currentShopBooking = HomeShopItemsService.instance.currentBooking;

    if (currentServiceBooking != null) {
      return ConfirmCardServiceItems(
          currentServiceBooking: currentServiceBooking);
    } else if (currentShopBooking != null) {
      return ConfirmCardShopItems(currentShopBooking: currentShopBooking);
    } else {
      return const Expanded(child: ErrorView());
    }
  }
}
