import 'package:flutter/material.dart';
import 'package:barber_shop/constants/colors.dart';

class TimeSlotCard extends StatelessWidget {
  final String timeSlot;
  final bool isPast;
  final bool isAvailable;
  final bool isSelected;
  final VoidCallback? onTap;

  const TimeSlotCard({
    super.key,
    required this.timeSlot,
    required this.isPast,
    required this.isAvailable,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isPast
        ? KColors.scaffoldBackGroundColor
        : !isAvailable
            ? Colors.red
            : isSelected
                ? Colors.yellowAccent.shade700
                : Colors.transparent;

    final textColor = isPast || !isAvailable ? Colors.grey : Colors.black;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          timeSlot,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
