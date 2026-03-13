import 'package:flutter/material.dart';

import '../../data/models/cart_item_model.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/cart_repository.dart';

class CartProvider extends ChangeNotifier {
  CartProvider(this._repository) {
    loadCart();
  }

  final CartRepository _repository;

  List<CartItemModel> _items = <CartItemModel>[];
  bool _loading = false;

  List<CartItemModel> get items => _items;
  bool get isLoading => _loading;

  double get total => _items.fold<double>(
        0,
        (sum, item) => sum + item.totalPrice,
      );

  int quantityForProduct(String productId) {
    final item = _items.firstWhere(
      (e) => e.product.id == productId,
      orElse: () => CartItemModel(
        product: ProductModel(
          id: '',
          name: '',
          description: '',
          price: 0,
          imagePath: '',
          rating: 0,
          category: '',
        ),
        quantity: 0,
      ),
    );
    return item.product.id.isEmpty ? 0 : item.quantity;
  }

  Future<void> loadCart() async {
    _loading = true;
    notifyListeners();
    _items = await _repository.loadCart();
    _loading = false;
    notifyListeners();
  }

  Future<void> add(ProductModel product) async {
    _items = await _repository.addToCart(_items, product);
    notifyListeners();
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    _items = await _repository.updateQuantity(_items, productId, quantity);
    notifyListeners();
  }

  Future<void> clear() async {
    await _repository.clearCart();
    _items = <CartItemModel>[];
    notifyListeners();
  }
}


