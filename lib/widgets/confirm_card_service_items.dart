import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/models/all_booking_model.dart';
import 'package:barber_shop/widgets/build_row_confirm_screen.dart';
import 'package:barber_shop/widgets/custom_divider.dart';
import 'package:flutter/material.dart';

class ConfirmCardServiceItems extends StatelessWidget {
  const ConfirmCardServiceItems({
    super.key,
    required this.currentServiceBooking,
  });

  final AllBookingModel? currentServiceBooking;

  @override
  Widget build(BuildContext context) {
    final serviceItemsNames = currentServiceBooking!.serviceItems
            ?.map((service) => service.title)
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
                  value: currentServiceBooking!.name!,
                ),
                const CustomDivider(),
                BuildRowConfirmScreen(
                  title: 'Services',
                  value: serviceItemsNames,
                ),
                const CustomDivider(),
                BuildRowConfirmScreen(
                  title: 'Total Price',
                  value: '${currentServiceBooking!.totalPrice} L.E',
                ),
                const CustomDivider(),
                BuildRowConfirmScreen(
                  title: 'Branch',
                  value: currentServiceBooking!.branchGovern!,
                  subValue: currentServiceBooking!.branchLocation,
                ),
                const CustomDivider(),
                BuildRowConfirmScreen(
                  title: 'Booked Time',
                  value: currentServiceBooking!.date!,
                  subValue: currentServiceBooking!.time,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
