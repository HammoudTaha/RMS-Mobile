class Table {
  final String id;
  final String tableNumber;
  final int capacity;

  Table({required this.id, required this.tableNumber, required this.capacity});

  factory Table.fromJson(Map<String, dynamic> json) {
    return Table(
      id: json['id'].toString(),
      tableNumber: json['table_number'],
      capacity: json['capacity'],
    );
  }
}
