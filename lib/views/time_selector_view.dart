import 'package:flutter/material.dart';
import 'package:barber_shop/constants/colors.dart';
import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/models/time_slots_model.dart';

class TimeSlotSelectorView extends StatelessWidget {
  const TimeSlotSelectorView({
    super.key,
    required this.selectedSlot,
    required this.onSlotSelected,
    required this.timeSlots,
    required this.selectedDate, // Add the selected date to check if it's today
  });

  final String? selectedSlot;
  final ValueChanged<String> onSlotSelected;
  final List<TimeSlotModel> timeSlots;
  final int selectedDate; // Selected day for booking

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final currentHour = now.hour;

    // Check if the selected day is today
    final isToday = selectedDate == now.day;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.screenWidth * 0.03,
        vertical: context.screenHeight * 0.005,
      ),
      child: Card(
        elevation: 0,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 10,
            mainAxisExtent: 84,
          ),
          itemCount: timeSlots.length,
          itemBuilder: (context, index) {
            final timeSlot = timeSlots[index].time;

            // Extract hour, minute, and AM/PM from the time slot (e.g., "9:00 AM")
            final parts = timeSlot.split(' ');
            final timePart = parts[0].split(':');
            final hour = int.parse(timePart[0]);
            final period = parts[1]; // AM or PM

            // Adjust hour for PM times
            int adjustedHour = hour;
            if (period == "PM" && hour != 12) {
              adjustedHour = hour + 12; // PM times (except 12 PM) should be +12
            } else if (period == "AM" && hour == 12) {
              adjustedHour = 0; // 12 AM is midnight, so set it to 0
            }

            // Check if the time slot has passed (only if it's today)
            final isPast = isToday
                ? (adjustedHour < currentHour) || (adjustedHour == currentHour)
                : false; // If not today, no time slot is considered "past"

            return GestureDetector(
              onTap: isPast ? null : () => onSlotSelected(timeSlot),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isPast
                      ? KColors
                          .scaffoldBackGroundColor // Disabled past hour background
                      : (selectedSlot == timeSlot
                          ? Colors
                              .yellowAccent.shade700 // Highlight selected slot
                          : Colors.transparent),
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  timeSlot,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        isPast ? Colors.grey : Colors.black, // Disabled color
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
