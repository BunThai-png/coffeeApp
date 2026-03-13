import '../database/local_storage.dart';
import '../models/cart_item_model.dart';
import '../models/order_model.dart';
import '../../core/utils/helpers.dart';

class OrderService {

  Future<List<OrderModel>> loadOrders() async {
    final raw = await LocalStorage.getString(LocalStorage.keyOrders);
    if (raw == null) return <OrderModel>[];
    final data = Helpers.decodeJson(raw);
    final list = data['items'] as List<dynamic>;
    return list
        .map(
          (e) => OrderModel.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  Future<void> saveOrders(List<OrderModel> orders) async {
    final payload = <String, dynamic>{
      'items': orders.map((e) => e.toJson()).toList(),
    };
    await LocalStorage.setString(
      LocalStorage.keyOrders,
      Helpers.encodeJson(payload),
    );
  }

  Future<List<OrderModel>> createOrder(
    List<OrderModel> current,
    List<CartItemModel> items,
  ) async {
    final total = items.fold<double>(
      0,
      (sum, item) => sum + item.totalPrice,
    );
    final newOrder = OrderModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      createdAt: DateTime.now(),
      items: items,
      total: total,
    );
    final updated = [newOrder, ...current];
    await saveOrders(updated);
    return updated;
  }
}


