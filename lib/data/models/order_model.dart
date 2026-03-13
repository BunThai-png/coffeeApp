import 'cart_item_model.dart';

class OrderModel {
  final String id;
  final DateTime createdAt;
  final List<CartItemModel> items;
  final double total;

  const OrderModel({
    required this.id,
    required this.createdAt,
    required this.items,
    required this.total,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      items: (json['items'] as List<dynamic>)
          .map(
            (e) => CartItemModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      total: (json['total'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'items': items.map((e) => e.toJson()).toList(),
      'total': total,
    };
  }
}



