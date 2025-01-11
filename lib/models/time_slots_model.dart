class TimeSlotModel {
  final String time;
  final bool isAvailable;

  TimeSlotModel({
    required this.time,
    required this.isAvailable,
  });

  // Optional: A factory method to create TimeSlot from Map entry
  factory TimeSlotModel.fromMap(MapEntry<String, bool> entry) {
    return TimeSlotModel(
      time: entry.key,
      isAvailable: entry.value,
    );
  }
}
