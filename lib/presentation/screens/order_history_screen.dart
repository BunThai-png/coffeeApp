import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/formatters.dart';
import '../providers/order_provider.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrderProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: orders.isLoading
          ? const Center(child: CircularProgressIndicator())
          : orders.orders.isEmpty
              ? const Center(child: Text('No orders yet'))
              : ListView.builder(
                  itemCount: orders.orders.length,
                  itemBuilder: (context, index) {
                    final order = orders.orders[index];
                    return ListTile(
                      title: Text(
                        'Order #${order.id}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${order.items.length} items • ${Formatters.price(order.total)}',
                      ),
                      trailing: Text(
                        '${order.createdAt.hour.toString().padLeft(2, '0')}:${order.createdAt.minute.toString().padLeft(2, '0')}',
                      ),
                    );
                  },
                ),
    );
  }
}


