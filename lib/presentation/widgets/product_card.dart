import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/formatters.dart';
import '../../data/models/product_model.dart';
import '../providers/cart_provider.dart';
import '../widgets/rating_stars.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  final ProductModel product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Theme.of(context).cardColor,
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: product.imagePath.isEmpty
                    ? Container(
                        color: Colors.brown.shade200,
                        child: const Center(
                          child: Icon(
                            Icons.local_cafe,
                            size: 48,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Image.asset(
                        product.imagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              product.description,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            RatingStars(rating: product.rating),
            const SizedBox(height: 4),
            Consumer<CartProvider>(
              builder: (context, cart, _) {
                final qty = cart.quantityForProduct(product.id);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Formatters.price(product.price),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: qty > 0
                              ? () => cart.updateQuantity(
                                    product.id,
                                    qty - 1,
                                  )
                              : null,
                        ),
                        Text('$qty'),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () {
                            if (qty == 0) {
                              cart.add(product);
                            } else {
                              cart.updateQuantity(
                                product.id,
                                qty + 1,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}