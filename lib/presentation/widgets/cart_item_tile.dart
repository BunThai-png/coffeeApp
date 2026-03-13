import 'package:flutter/material.dart';

import '../../core/utils/formatters.dart';
import '../../data/models/cart_item_model.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({
    super.key,
    required this.item,
    required this.onQuantityChanged,
  });

  final CartItemModel item;
  final void Function(int quantity) onQuantityChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          item.product.imagePath,
          width: 48,
          height: 48,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(item.product.name),
      subtitle: Text(Formatters.price(item.product.price)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed:
                item.quantity > 1 ? () => onQuantityChanged(item.quantity - 1) : null,
          ),
          Text('${item.quantity}'),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () => onQuantityChanged(item.quantity + 1),
          ),
        ],
      ),
    );
  }
}



