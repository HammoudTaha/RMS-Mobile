class Date {
  final String restaurantId;
  final int partySize;
  final List<DateItem> dates;
  Date({
    required this.restaurantId,
    required this.partySize,
    required this.dates,
  });

  factory Date.fromJson(Map<String, dynamic> json) {
    return Date(
      restaurantId: json['restaurant']['id'].toString(),
      partySize: json['party_size'],
      dates:
          (json['available_dates'] as List)
              .map((e) => DateItem.fromJson(e))
              .toList(),
    );
  }
}

class DateItem {
  final String date;
  final String dayName;
  DateItem({required this.date, required this.dayName});

  factory DateItem.fromJson(Map<String, dynamic> json) {
    return DateItem(date: json['date'], dayName: json['day_name']);
  }
}
