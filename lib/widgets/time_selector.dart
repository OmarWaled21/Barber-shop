import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:flutter/material.dart';

class TimeSlotSelector extends StatelessWidget {
  final String? selectedSlot;
  final ValueChanged<String> onSlotSelected;

  const TimeSlotSelector({
    super.key,
    required this.selectedSlot,
    required this.onSlotSelected,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final currentHour = now.hour;

    final List<String> timeSlots = List.generate(
      15, // Number of slots (from 9:00 AM to 11:00 PM)
      (index) {
        final hour = 9 + index;
        final period = hour >= 12 ? 'PM' : 'AM';
        final formattedHour = hour > 12 ? hour - 12 : hour;
        return '${formattedHour.toString().padLeft(2, '0')}:00 $period';
      },
    );

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
            final hour = 9 + index; // Convert index to actual hour
            final timeSlot = timeSlots[index];
            final isPastHour = hour < currentHour;

            return GestureDetector(
              onTap: isPastHour ? null : () => onSlotSelected(timeSlot),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isPastHour
                      ? Colors.grey.shade300 // Disabled past hour background
                      : (selectedSlot == timeSlot
                          ? Colors.yellowAccent.shade700
                          : Colors.transparent),
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  timeSlot,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isPastHour ? Colors.grey : Colors.black,
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
