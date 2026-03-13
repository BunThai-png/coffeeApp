import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/formatters.dart';
import '../../routes/app_routes.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item_tile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: cart.isLoading
          ? const Center(child: CircularProgressIndicator())
          : cart.items.isEmpty
              ? const Center(child: Text('Your cart is empty'))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cart.items.length,
                        itemBuilder: (context, index) {
                          final item = cart.items[index];
                          return CartItemTile(
                            item: item,
                            onQuantityChanged: (quantity) {
                              cart.updateQuantity(item.product.id, quantity);
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                Formatters.price(cart.total),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: cart.items.isEmpty
                                ? null
                                : () async {
                                    final shouldContinue =
                                        await showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title:
                                            const Text('Confirm purchase?'),
                                        content: const Text(
                                          'Do you want to proceed to buy these items? You can withdraw if you change your mind.',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(false),
                                            child: const Text('Withdraw'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(true),
                                            child: const Text('Continue'),
                                          ),
                                        ],
                                      ),
                                    );
                                    if (shouldContinue == true &&
                                        context.mounted) {
                                      Navigator.of(context)
                                          .pushNamed(AppRoutes.checkout);
                                    }
                                  },
                            child: const Text('Buy'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}


