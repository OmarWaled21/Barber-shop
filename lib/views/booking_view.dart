import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/helper/navigator_extention.dart';
import 'package:barber_shop/services/time_day_service.dart';
import 'package:barber_shop/views/confirm_view.dart';
import 'package:barber_shop/widgets/custom_app_bar.dart';
import 'package:barber_shop/widgets/custom_button.dart';
import 'package:barber_shop/widgets/day_selector.dart';
import 'package:barber_shop/widgets/time_selector.dart';
import 'package:flutter/material.dart';

class BookingDateView extends StatefulWidget {
  const BookingDateView({super.key});

  @override
  State<BookingDateView> createState() => _BookingDateViewState();
}

class _BookingDateViewState extends State<BookingDateView> {
  int? _selectedDay;
  String? _selectedTimeSlot;

  void _updateSelectedDay(int day) {
    setState(() {
      _selectedDay = day;
    });
  }

  void _updateSelectedTimeSlot(String timeSlot) {
    setState(() {
      _selectedTimeSlot = timeSlot;
    });
  }

  @override
  void initState() {
    super.initState();
    TimeDayService().createTimeSlotsForNewDay();
  }

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
          DaySelector(
            selectedDay: _selectedDay,
            onDaySelected: _updateSelectedDay,
          ),
          TimeSlotSelector(
            selectedSlot: _selectedTimeSlot,
            onSlotSelected: _updateSelectedTimeSlot,
          ),
          SizedBox(
            height: context.screenHeight * 0.05,
            width: context.screenWidth * 0.5,
            child: CustomButton(
              onPressed: _selectedDay != null && _selectedTimeSlot != null
                  ? () {
                      context.push(
                        const ConfirmView(
                            // selectedDay: _selectedDay!,
                            // selectedTimeSlot: _selectedTimeSlot!,
                            ),
                      );
                    }
                  : null,
              title: 'Continue',
            ),
          ),
        ],
      ),
    );
  }
}
