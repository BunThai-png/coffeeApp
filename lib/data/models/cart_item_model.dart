import 'product_model.dart';

class CartItemModel {
  final ProductModel product;
  final int quantity;

  const CartItemModel({
    required this.product,
    required this.quantity,
  });

  CartItemModel copyWith({ProductModel? product, int? quantity}) {
    return CartItemModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  double get totalPrice => product.price * quantity;

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      product: ProductModel.fromJson(
        json['product'] as Map<String, dynamic>,
      ),
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'product': product.toJson(),
      'quantity': quantity,
    };
  }
}


