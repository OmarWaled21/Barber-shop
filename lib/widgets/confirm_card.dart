import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/services/home_service_items_service.dart';
import 'package:barber_shop/views/error_view.dart';
import 'package:barber_shop/widgets/build_row_confirm_screen.dart';
import 'package:barber_shop/widgets/custom_divider.dart';
import 'package:flutter/material.dart';

class ConfirmCard extends StatelessWidget {
  const ConfirmCard({super.key});

  @override
  Widget build(BuildContext context) {
    final currentBooking = HomeServiceItemsService.instance.currentBooking;

    if (currentBooking != null) {
      final serviceItemsNames = currentBooking.serviceItems
              ?.map((service) => service.title)
              .toList()
              .join(', ') ??
          'No services selected';

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
                    value: currentBooking.name!,
                  ),
                  const CustomDivider(),
                  BuildRowConfirmScreen(
                    title: 'Items',
                    value: serviceItemsNames,
                  ),
                  const CustomDivider(),
                  BuildRowConfirmScreen(
                    title: 'Total Price',
                    value: '${currentBooking.totalPrice} L.E',
                  ),
                  const CustomDivider(),
                  BuildRowConfirmScreen(
                    title: 'Branch',
                    value: currentBooking.branchGovern!,
                    subValue: currentBooking.branchLocation,
                  ),
                  const CustomDivider(),
                  BuildRowConfirmScreen(
                    title: 'Booked Time',
                    value: currentBooking.date!,
                    subValue: currentBooking.time,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return const ErrorView();
    }
  }
}
