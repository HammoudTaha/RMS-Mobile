class BookItem {
  final String id;
  final String tableNumber;
  final String date;
  final String time;

  BookItem({
    required this.id,
    required this.tableNumber,
    required this.date,
    required this.time,
  });

  factory BookItem.fromJson(Map<String, dynamic> json) {
    return BookItem(
      id: json['id'].toString(),
      tableNumber: json['table'],
      date: json['date'],
      time: json['time'],
    );
  }
}
