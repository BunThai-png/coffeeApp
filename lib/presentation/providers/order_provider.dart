import 'package:flutter/material.dart';

import '../../data/models/cart_item_model.dart';
import '../../data/models/order_model.dart';
import '../../data/repositories/order_repository.dart';

class OrderProvider extends ChangeNotifier {
  OrderProvider(this._repository) {
    loadOrders();
  }

  final OrderRepository _repository;

  List<OrderModel> _orders = <OrderModel>[];
  bool _loading = false;

  List<OrderModel> get orders => _orders;
  bool get isLoading => _loading;

  Future<void> loadOrders() async {
    _loading = true;
    notifyListeners();
    _orders = await _repository.loadOrders();
    _loading = false;
    notifyListeners();
  }

  Future<void> placeOrder(List<CartItemModel> items) async {
    _orders = await _repository.createOrder(_orders, items);
    notifyListeners();
  }
}


