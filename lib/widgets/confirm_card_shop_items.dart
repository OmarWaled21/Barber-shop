import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/models/all_booking_model.dart';
import 'package:barber_shop/widgets/build_row_confirm_screen.dart';
import 'package:barber_shop/widgets/custom_divider.dart';
import 'package:flutter/material.dart';

class ConfirmCardShopItems extends StatelessWidget {
  const ConfirmCardShopItems({
    super.key,
    required this.currentShopBooking,
  });

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
                BuildRowConfirmScreen(
                  title: 'Name',
                  value: currentShopBooking!.name!,
                ),
                const CustomDivider(),
                BuildRowConfirmScreen(
                  title: 'Items',
                  value: shopItemsNames,
                ),
                const CustomDivider(),
                BuildRowConfirmScreen(
                  title: 'Total Price',
                  value: '${currentShopBooking!.totalPrice} L.E',
                ),
                const CustomDivider(),
                BuildRowConfirmScreen(
                  title: 'Branch',
                  value: currentShopBooking!.branchGovern!,
                  subValue: currentShopBooking!.branchLocation,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
