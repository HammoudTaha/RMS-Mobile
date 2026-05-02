class Duration {
  final String restaurantId;
  final int partySize;
  final String date;
  final String time;
  final List<DurationItem> durations;

  Duration({
    required this.restaurantId,
    required this.partySize,
    required this.date,
    required this.time,
    required this.durations,
  });

  factory Duration.fromJson(Map<String, dynamic> json) {
    return Duration(
      restaurantId: json['restaurant']['id'].toString(),
      partySize: json['party_size'],
      date: json['date'],
      time: json['time'],
      durations:
          (json['available_durations'] as List)
              .map((e) => DurationItem.fromJson(e))
              .toList(),
    );
  }
}

class DurationItem {
  final int duration;
  final int tables;
  final String displayDuration;

  DurationItem({
    required this.duration,
    required this.tables,
    required this.displayDuration,
  });

  factory DurationItem.fromJson(Map<String, dynamic> json) {
    return DurationItem(
      duration: json['duration'],
      tables: json['available_tables'],
      displayDuration: json['display_text'],
    );
  }
}
