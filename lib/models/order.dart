import 'cart_item.dart';

class Order {
  final String userId;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String location;
  final List<CartItem> items;
  final int total;

  Order({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.location,
    required this.items,
    required this.total,
  });

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'location': location,
        'items': items.map((e) => e.toMap()).toList().toString(),
        'total': total,
      };
}
