// lib/services/add_2_calender_service.dart

import 'package:add_2_calendar/add_2_calendar.dart';

class AddToCalendarService {
  Future<void> addEventToCalendar({
    required String title,
    required DateTime startTime,
    required DateTime endTime,
    required String description,
  }) async {
    // Use the add_2_calendar package to add the event to the calendar
    final event = Event(
      title: title,
      description: description,
      startDate: startTime,
      endDate: endTime,
    );

    await Add2Calendar.addEvent2Cal(event);
  }

  DateTime parseSelectedTimeSlot(int selectedDay, String selectedTimeSlot) {
    // Parse the selected time slot (e.g., "8:00 AM") into hour and minute
    final parts = selectedTimeSlot.split(' ');
    final timeParts = parts[0].split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);

    // Determine AM or PM and adjust the hour accordingly
    int adjustedHour = hour;
    if (parts[1] == 'PM' && adjustedHour != 12) {
      adjustedHour += 12;
    } else if (parts[1] == 'AM' && adjustedHour == 12) {
      adjustedHour = 0;
    }

    // Construct the selected date using the chosen day and current year/month
    final selectedDate = DateTime.now().copyWith(day: selectedDay);

    // Construct the start time by combining the selected date with the selected time
    final startTime = DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, adjustedHour, minute);

    return startTime;
  }
}
