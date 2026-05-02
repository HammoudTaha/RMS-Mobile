import 'dart:math';

import 'package:hive/hive.dart';
part 'delivery_info.g.dart';

@HiveType(typeId: 4)
class DeliveryInfo {
  final id =
      (Random().nextInt(1000000) * DateTime.now().microsecond).toString();
  @HiveField(0)
  final String address;
  @HiveField(1)
  final String phone;
  DeliveryInfo({required this.address, required this.phone});

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) {
    return DeliveryInfo(address: json['address'], phone: json['phone']);
  }

  DeliveryInfo copyWith({String? address, String? phone}) {
    return DeliveryInfo(
      address: address ?? this.address,
      phone: phone ?? this.phone,
    );
  }
}
