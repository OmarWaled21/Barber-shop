import 'package:barber_shop/constants/colors.dart';
import 'package:barber_shop/helper/media_query_extention.dart';
import 'package:barber_shop/widgets/day_header_row.dart';
import 'package:flutter/material.dart';

class DaySelectorView extends StatelessWidget {
  const DaySelectorView(
      {super.key, this.selectedDay, required this.onDaySelected});

  final int? selectedDay;
  final ValueChanged<int> onDaySelected;

  @override
  Widget build(BuildContext context) {
    final int currentDay = DateTime.now().day;
    const int daysInWeek = 7;
    const int totalDays = 31;

    // Calculate rows and filter to show only current and future rows
    final rows = _generateRows(totalDays, daysInWeek)
        .sublist((currentDay - 1) ~/ daysInWeek);

    return SizedBox(
      height: context.screenHeight * 0.21,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.05),
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const HeaderRow(),
              _buildDayGrid(rows, currentDay),
            ],
          ),
        ),
      ),
    );
  }

  /// Generates rows of days with each row containing [daysInWeek] days.
  List<List<int>> _generateRows(int totalDays, int daysInWeek) {
    return List.generate(
      (totalDays / daysInWeek).ceil(),
      (rowIndex) => List.generate(
        daysInWeek,
        (dayIndex) => rowIndex * daysInWeek + dayIndex + 1,
      ).where((day) => day <= totalDays).toList(),
    );
  }

  /// Builds the day grid showing only valid days.
  Widget _buildDayGrid(List<List<int>> rows, int currentDay) {
    final allDays = rows.expand((row) => row).toList();

    return Expanded(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 1.0,
        ),
        itemCount: allDays.length,
        itemBuilder: (context, index) {
          final day = allDays[index];
          final isPastDay = day < currentDay;

          return GestureDetector(
            onTap: isPastDay ? null : () => onDaySelected(day),
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: _getDayBackgroundColor(day, isPastDay),
              ),
              child: Text(
                "$day",
                style: TextStyle(
                  fontSize: 16.0,
                  color: _getDayTextColor(isPastDay),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Determines the background color for a day.
  Color _getDayBackgroundColor(int day, bool isPastDay) {
    if (isPastDay) return KColors.greyColor;
    return (selectedDay == day)
        ? KColors.mainColor
        : KColors.scaffoldBackGroundColor;
  }

  /// Determines the text color for a day.
  Color _getDayTextColor(bool isPastDay) {
    return isPastDay ? Colors.grey : Colors.black;
  }
}
