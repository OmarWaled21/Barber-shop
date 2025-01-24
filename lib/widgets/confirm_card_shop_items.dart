import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/models/all_booking_model.dart';
import 'package:barber_shop/widgets/build_row_confirm_screen.dart';
import 'package:barber_shop/widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConfirmCardShopItems extends StatelessWidget {
  const ConfirmCardShopItems({super.key, required this.currentShopBooking});

  final AllBookingModel? currentShopBooking;

  @override
  Widget build(BuildContext context) {
    final shopItemsNames = currentShopBooking!.shopItems
            ?.map((shop) => '${shop.title}: ${shop.price} L.E')
            .toList()
            .join(', ') ??
        '';
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.screenWidth * 0.07,
            vertical: context.screenHeight * 0.02),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(context.screenWidth * 0.05),
            child: ListView(
              children: [
                const Center(
                  child: Text(
                    'Invoice',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: context.screenHeight * 0.02),
                const Divider(),

                // Client Information Section
                const Text(
                  'Client Information',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                BuildRowConfirmScreen(
                  title: 'Name',
                  value: currentShopBooking!.name!,
                ),
                BuildRowConfirmScreen(
                  title: 'Location',
                  value: currentShopBooking!.userLocation!,
                ),
                const CustomDivider(),
                // Items Section
                const Text(
                  'Items Purchased',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                BuildRowConfirmScreen(
                  title: 'Items',
                  value: shopItemsNames,
                ),
                const CustomDivider(),
                // Total Price Section
                const Text(
                  'Total Price',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                BuildRowConfirmScreen(
                  title: 'Total',
                  value: '${currentShopBooking!.totalPrice} L.E',
                ),
                const CustomDivider(),
                const Text(
                  'Date and Time',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                BuildRowConfirmScreen(
                  title: "Date",
                  value:
                      "${DateFormat('MMM dd, yyyy').format(DateTime.now().toLocal())} / ${DateFormat().add_jm().format(DateTime.now().toLocal())}",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
