import '../database/local_storage.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart';
import '../../core/utils/helpers.dart';

class CartService {

  Future<List<CartItemModel>> loadCart() async {
    final raw = await LocalStorage.getString(LocalStorage.keyCart);
    if (raw == null) return <CartItemModel>[];
    final data = Helpers.decodeJson(raw);
    final list = data['items'] as List<dynamic>;
    return list
        .map(
          (e) => CartItemModel.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  Future<void> saveCart(List<CartItemModel> items) async {
    final payload = <String, dynamic>{
      'items': items.map((e) => e.toJson()).toList(),
    };
    await LocalStorage.setString(
      LocalStorage.keyCart,
      Helpers.encodeJson(payload),
    );
  }

  Future<List<CartItemModel>> addToCart(
    List<CartItemModel> current,
    ProductModel product,
  ) async {
    final updated = [...current];
    final index = updated.indexWhere((e) => e.product.id == product.id);
    if (index >= 0) {
      final item = updated[index];
      updated[index] = item.copyWith(quantity: item.quantity + 1);
    } else {
      updated.add(
        CartItemModel(
          product: product,
          quantity: 1,
        ),
      );
    }
    await saveCart(updated);
    return updated;
  }

  Future<List<CartItemModel>> updateQuantity(
    List<CartItemModel> current,
    String productId,
    int quantity,
  ) async {
    final updated = current
        .map(
          (e) => e.product.id == productId
              ? e.copyWith(quantity: quantity)
              : e,
        )
        .where((e) => e.quantity > 0)
        .toList();
    await saveCart(updated);
    return updated;
  }

  Future<void> clearCart() async {
    await saveCart(<CartItemModel>[]);
  }
}


