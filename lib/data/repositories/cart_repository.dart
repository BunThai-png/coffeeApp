import '../models/cart_item_model.dart';
import '../models/product_model.dart';
import '../services/cart_service.dart';

class CartRepository {
  CartRepository(this._service);

  final CartService _service;

  Future<List<CartItemModel>> loadCart() {
    return _service.loadCart();
  }

  Future<List<CartItemModel>> addToCart(
    List<CartItemModel> current,
    ProductModel product,
  ) {
    return _service.addToCart(current, product);
  }

  Future<List<CartItemModel>> updateQuantity(
    List<CartItemModel> current,
    String productId,
    int quantity,
  ) {
    return _service.updateQuantity(current, productId, quantity);
  }

  Future<void> clearCart() {
    return _service.clearCart();
  }
}


