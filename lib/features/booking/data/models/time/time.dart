class Time {
  final String restaurantId;
  final int partySize;
  final String date;
  final List<TimeItem> times;

  Time({
    required this.restaurantId,
    required this.partySize,
    required this.date,
    required this.times,
  });

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      restaurantId: json['restaurant']['id'].toString(),
      partySize: json['party_size'],
      date: json['date'],
      times:
          (json['available_times'] as List)
              .map((e) => TimeItem.fromJson(e))
              .toList(),
    );
  }
}

class TimeItem {
  final String time;
  final String displayTime;

  TimeItem({required this.time, required this.displayTime});

  factory TimeItem.fromJson(Map<String, dynamic> json) {
    return TimeItem(time: json['time'], displayTime: json['display_time']);
  }
}
