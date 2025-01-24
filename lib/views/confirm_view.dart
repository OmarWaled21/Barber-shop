import 'package:barber_shop/constants/colors.dart';
import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/helper/navigator_extention.dart';
import 'package:barber_shop/services/booking_confirmation_service.dart';
import 'package:barber_shop/services/home_service_items_service.dart';
import 'package:barber_shop/views/home_view.dart';
import 'package:barber_shop/widgets/confirm_card.dart';
import 'package:barber_shop/widgets/custom_app_bar.dart';
import 'package:barber_shop/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ConfirmView extends StatelessWidget {
  const ConfirmView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth, context.screenHeight * 0.09),
        child: CustomAppBar(
          color: KColors.mainColor,
          title: 'Confirm Booking',
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
      ),
      body: Column(
        children: [
          const ConfirmCard(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.screenWidth * 0.07,
                vertical: context.screenHeight * 0.02,
              ),
              child: CustomButton(
                onPressed: () async {
                  await HomeServiceItemsService.instance.changeAvailablity();
                  await HomeServiceItemsService.instance
                      .confirmBooking(context);
                  context.pushAndRemoveUntil(const HomeView());
                },
                title: 'Confirm Order',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
