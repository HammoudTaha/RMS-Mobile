import 'package:hive/hive.dart';
import '../../../../restaurant/data/models/menu/menu.dart';
part 'cart.g.dart';

@HiveType(typeId: 3)
class Cart {
  @HiveField(0)
  final Menu menu;
  @HiveField(1)
  int quantity;
  @HiveField(2)
  String? note;
  Cart({required this.menu, this.quantity = 1, this.note});

  Cart copyWith({int? quantity, String? note}) {
    return Cart(menu: menu, quantity: quantity ?? this.quantity, note: note);
  }
}
