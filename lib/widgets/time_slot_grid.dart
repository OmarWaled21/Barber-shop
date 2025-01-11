import 'package:flutter/material.dart';
import 'package:barber_shop/models/time_slots_model.dart';
import 'time_slot_card.dart';

class TimeSlotGrid extends StatelessWidget {
  final List<TimeSlotModel> timeSlots;
  final String? selectedSlot;
  final bool isToday;
  final int currentHour;
  final int currentMinute; // Added currentMinute
  final ValueChanged<String> onSlotSelected;

  const TimeSlotGrid({
    super.key,
    required this.timeSlots,
    required this.selectedSlot,
    required this.isToday,
    required this.currentHour,
    required this.currentMinute, // Added currentMinute
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
        int adjustedHour = (period == "PM" && hour != 12)
            ? hour + 12
            : (period == "AM" && hour == 12)
                ? 0
                : hour;

        // Compare hour and minute to determine if the slot is past
        final isPast = isToday &&
            (adjustedHour < currentHour ||
                (adjustedHour == currentHour && minute < currentMinute));

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
