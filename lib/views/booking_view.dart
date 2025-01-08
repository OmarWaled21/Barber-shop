import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/widgets/custom_button.dart';
import 'package:barber_shop/widgets/day_selector.dart';
import 'package:barber_shop/widgets/time_selector.dart';
import 'package:flutter/material.dart';

class BookingDateView extends StatelessWidget {
  const BookingDateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(
          'Choose Your Day',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.yellow.shade900,
          ),
        ),
      ),
      body: Column(
        children: [
          const DaySelector(),
          const TimeSlotSelector(),
          SizedBox(
            height: context.screenHeight * 0.05,
            width: context.screenWidth * 0.5,
            child: CustomButton(onPressed: () {}, title: 'Continue'),
          ),
        ],
      ),
    );
  }
}
