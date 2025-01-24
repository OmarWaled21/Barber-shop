import 'package:flutter/material.dart';
import 'package:barber_shop/models/time_slots_model.dart';
import 'time_slot_card.dart';

class TimeSlotGrid extends StatelessWidget {
  final List<TimeSlotModel> timeSlots;
  final String? selectedSlot;
  final bool isToday;
  final int currentHour;
  final int currentMinute;
  final ValueChanged<String> onSlotSelected;

  const TimeSlotGrid({
    super.key,
    required this.timeSlots,
    required this.selectedSlot,
    required this.isToday,
    required this.currentHour,
    required this.currentMinute,
    required this.onSlotSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
        final timeSlot = timeSlots[index];
        final time = timeSlot.time;
        final isAvailable = timeSlot.isAvailable;

        // Time parsing logic
        final parts = time.split(' ');
        final hour = int.parse(parts[0].split(':')[0]);
        final minute = int.parse(parts[0].split(':')[1]);
        final period = parts[1];

        // Convert the time slot to 24-hour format
        int adjustedHour = hour;
        if (period == "PM" && hour != 12) {
          adjustedHour += 12; // Convert PM to 24-hour format
        } else if (period == "AM" && hour == 12) {
          adjustedHour = 0; // Convert 12:00 AM to 00:00
        }

        // Compare the time slot with the current time
        bool isPast = false;
        if (isToday) {
          if (adjustedHour < currentHour ||
              (adjustedHour == currentHour && minute < currentMinute)) {
            isPast = true;
          }
        }

        return TimeSlotCard(
          timeSlot: time,
          isPast: isPast,
          isAvailable: isAvailable,
          isSelected: selectedSlot == time,
          onTap: isPast || !isAvailable ? null : () => onSlotSelected(time),
        );
      },
    );
  }
}
