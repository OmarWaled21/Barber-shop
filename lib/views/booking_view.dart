import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/helper/navigator_extention.dart';
import 'package:barber_shop/views/confirm_view.dart';
import 'package:barber_shop/widgets/custom_app_bar.dart';
import 'package:barber_shop/widgets/custom_button.dart';
import 'package:barber_shop/widgets/day_selector.dart';
import 'package:barber_shop/widgets/time_selector.dart';
import 'package:flutter/material.dart';

class BookingDateView extends StatelessWidget {
  const BookingDateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: 'Choose your Day',
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          const DaySelector(),
          const TimeSlotSelector(),
          SizedBox(
            height: context.screenHeight * 0.05,
            width: context.screenWidth * 0.5,
            child: CustomButton(
              onPressed: () {
                context.push(const ConfirmView());
              },
              title: 'Continue',
            ),
          ),
        ],
      ),
    );
  }
}
