import '../../../../../core/utils/enum.dart';
import '../../../../home/data/models/restaurant/restaurant.dart';

class Booking {
  final String id;
  final Restaurant restaurant;
  final String table;
  final int partySize;
  final String date;
  final String time;
  final BookStatus status;

  const Booking({
    required this.id,
    required this.restaurant,
    required this.table,
    required this.partySize,
    required this.date,
    required this.time,
    required this.status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    json['restaurant']['category'] =
        json['restaurant']['categories'][0]['name'];
    return Booking(
      id: json['id'].toString(),
      restaurant: Restaurant.formJson(json['restaurant']),
      table: json['table'],
      partySize: json['party_size'],
      date: json['date'],
      time: json['time'],
      status:
          json['status'] == 'pending'
              ? BookStatus.active
              : json['status'] == 'cancelled'
              ? BookStatus.cancelled
              : BookStatus.complated,
    );
  }
}
