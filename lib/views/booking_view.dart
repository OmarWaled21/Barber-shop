import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/helper/navigator_extention.dart';
import 'package:barber_shop/models/time_slots_model.dart';
import 'package:barber_shop/services/time_day_service.dart';
import 'package:barber_shop/views/confirm_view.dart';
import 'package:barber_shop/views/time_selector_view.dart';
import 'package:barber_shop/widgets/custom_app_bar.dart';
import 'package:barber_shop/widgets/custom_button.dart';
import 'package:barber_shop/views/day_selector_view.dart';
import 'package:flutter/material.dart';

class BookingDateView extends StatefulWidget {
  const BookingDateView({super.key});

  @override
  State<BookingDateView> createState() => _BookingDateViewState();
}

class _BookingDateViewState extends State<BookingDateView> {
  int? _selectedDay;
  String? _selectedTimeSlot;
  List<TimeSlotModel> _timeSlots = []; // To store time slots

  void _updateSelectedDay(int day) async {
    setState(() => _selectedDay = day);
    // Create time slots for the selected day
    await TimeDayService().createTimeSlotsForNewDay(day);
    // Fetch available time slots for the selected day
    final timeSlots = await TimeDayService().getTimeSlots(day);

    setState(() {
      _timeSlots = timeSlots; // Set the fetched time slots
      _selectedTimeSlot =
          null; // Reset the selected time slot when the day changes
    });
  }

  void _updateSelectedTimeSlot(String timeSlot) {
    setState(() => _selectedTimeSlot = timeSlot);
  }

  @override
  void initState() {
    super.initState();
    TimeDayService().createTimeSlotsForNewDay(DateTime.now().day);
    // Fetch time slots for the current day initially
    TimeDayService().getTimeSlots(DateTime.now().day).then((timeSlots) {
      setState(() {
        _timeSlots = timeSlots; // Set the fetched time slots
      });
    });
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
          DaySelectorView(
            selectedDay: _selectedDay,
            onDaySelected: _updateSelectedDay,
          ),
          TimeSlotSelectorView(
            timeSlots: _timeSlots,
            selectedDate: _selectedDay ?? DateTime.now().day,
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
