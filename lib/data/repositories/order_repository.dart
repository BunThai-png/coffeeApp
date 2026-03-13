import '../models/cart_item_model.dart';
import '../models/order_model.dart';
import '../services/order_service.dart';

class OrderRepository {
  OrderRepository(this._service);

  final OrderService _service;

  Future<List<OrderModel>> loadOrders() {
    return _service.loadOrders();
  }

  Future<List<OrderModel>> createOrder(
    List<OrderModel> current,
    List<CartItemModel> items,
  ) {
    return _service.createOrder(current, items);
  }
}


