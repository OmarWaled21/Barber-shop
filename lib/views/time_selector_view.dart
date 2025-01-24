import 'package:barber_shop/views/loading_view.dart';
import 'package:barber_shop/widgets/time_slot_grid.dart';
import 'package:flutter/material.dart';
import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/models/time_slots_model.dart';

class TimeSlotSelectorView extends StatelessWidget {
  final String? selectedSlot;
  final ValueChanged<String> onSlotSelected;
  final Stream<List<TimeSlotModel>> dayStream;
  final int selectedDate;

  const TimeSlotSelectorView({
    super.key,
    required this.selectedSlot,
    required this.onSlotSelected,
    required this.dayStream,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final currentHour = now.hour;
    final currentMinute = now.minute;
    final isToday = selectedDate == now.day;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.screenWidth * 0.03,
        vertical: context.screenHeight * 0.005,
      ),
      child: Card(
        elevation: 0,
        child: StreamBuilder<List<TimeSlotModel>>(
          stream: dayStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: LoadingView());
            }

            final timeSlots = snapshot.data!;
            return TimeSlotGrid(
              timeSlots: timeSlots,
              selectedSlot: selectedSlot,
              isToday: isToday,
              currentMinute: currentMinute,
              currentHour: currentHour,
              onSlotSelected: onSlotSelected,
            );
          },
        ),
      ),
    );
  }
}
