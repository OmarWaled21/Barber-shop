import 'package:barber_shop/constants/colors.dart';
import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/helper/navigator_extention.dart';
import 'package:barber_shop/views/booking_view.dart';
import 'package:barber_shop/widgets/custom_button.dart';
import 'package:barber_shop/widgets/service_home_grid_view.dart';
import 'package:flutter/material.dart';

class HomeServiceBody extends StatelessWidget {
  const HomeServiceBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        const ServiceHomeGridView(),
        const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text(
            'Total Price: 50 L.E',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: KColors.darkerYellowColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.2),
          child: CustomButton(
            onPressed: () {
              context.push(const BookingDateView());
            },
            title: 'Book',
          ),
        ),
      ],
    );
  }
}
