import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/helper/navigator_extention.dart';
import 'package:barber_shop/services/add_2_calender_service.dart';
import 'package:barber_shop/services/home_service_items_service.dart';
import 'package:barber_shop/services/time_day_service.dart';
import 'package:barber_shop/views/confirm_view.dart';
import 'package:barber_shop/views/day_selector_view.dart';
import 'package:barber_shop/views/time_selector_view.dart';
import 'package:barber_shop/widgets/custom_app_bar.dart';
import 'package:barber_shop/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class BookingDateView extends StatefulWidget {
  const BookingDateView({super.key});

  @override
  State<BookingDateView> createState() => _BookingDateViewState();
}

class _BookingDateViewState extends State<BookingDateView> {
  int _selectedDay = DateTime.now().day;
  String? _selectedTimeSlot;

  void _updateSelectedDay(int day) async {
    setState(() => _selectedDay = day);
    await TimeDayService().createTimeSlotsForNewDay(day);
    setState(() => _selectedTimeSlot = null);
  }

  void _updateSelectedTimeSlot(String timeSlot) {
    setState(() => _selectedTimeSlot = timeSlot);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: 'Choose your Day',
            leading: IconButton(
              onPressed: () {
                context.pop();
                HomeServiceItemsService.instance.currentBooking = null;
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          DaySelectorView(
            selectedDay: _selectedDay,
            onDaySelected: _updateSelectedDay,
          ),
          Expanded(
            child: TimeSlotSelectorView(
              selectedSlot: _selectedTimeSlot,
              onSlotSelected: _updateSelectedTimeSlot,
              dayStream: TimeDayService().getTimeSlotsStream(_selectedDay),
              selectedDate: _selectedDay,
            ),
          ),
          SizedBox(
            height: context.screenHeight * 0.05,
            width: context.screenWidth * 0.5,
            child: CustomButton(
              onPressed: _selectedTimeSlot != null
                  ? () async {
                      _addToCalendar();
                      _saveBooking();
                      context.push(const ConfirmView());
                    }
                  : null,
              title: 'Continue',
            ),
          ),
        ],
      ),
    );
  }

  void _addToCalendar() async {
    if (_selectedTimeSlot != null) {
      // Get the parsed start time
      final startTime = AddToCalendarService()
          .parseSelectedTimeSlot(_selectedDay, _selectedTimeSlot!);

      // Set the event duration (e.g., 1 hour)
      final endTime = startTime.add(const Duration(hours: 1));

      // Add the event to the calendar
      await AddToCalendarService().addEventToCalendar(
        title: 'Booking Appointment',
        startTime: startTime,
        endTime: endTime,
        description: 'Your booking at Barber Shop',
      );
    }
  }

  // Save booking with date and time to AllBookingModel
  void _saveBooking() async {
    if (_selectedTimeSlot != null) {
      final bookingDate = _selectedDay.toString(); // Format the day as needed
      final bookingTime = _selectedTimeSlot!; // Use the selected time slot

      // Save the booking with date and time to AllBookingModel
      await HomeServiceItemsService.instance.saveBookingHistory(
        selectedDate: bookingDate, // Pass selected date
        selectedTime: bookingTime, // Pass selected time
      );
    }
  }
}
