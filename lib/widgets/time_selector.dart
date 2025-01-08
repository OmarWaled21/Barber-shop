import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:flutter/material.dart';

class TimeSlotSelector extends StatefulWidget {
  const TimeSlotSelector({super.key});

  @override
  State<TimeSlotSelector> createState() => _TimeSlotSelectorState();
}

class _TimeSlotSelectorState extends State<TimeSlotSelector> {
  int? _selectedSlot;

  // Generate a list of times from 9:00 AM to 11:00 PM
  final List<String> _timeSlots = List.generate(
    15, // Number of slots (from 9:00 AM to 11:00 PM)
    (index) {
      final hour = 9 + (index); // Calculate the hour
      final period = hour >= 12 ? 'PM' : 'AM'; // AM/PM
      final formattedHour =
          hour > 12 ? hour - 12 : hour; // Convert to 12-hour format
      return '${formattedHour.toString().padLeft(2, '0')}:00 $period';
    },
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.screenWidth * 0.03,
        right: context.screenWidth * 0.03,
        bottom: context.screenHeight * 0.005,
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
          itemCount: _timeSlots.length, // Use the generated time slots count
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedSlot = index;
                });
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _selectedSlot == index
                      ? Colors.yellowAccent.shade700
                      : Colors.transparent,
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  _timeSlots[index], // Display the time slot
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
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
