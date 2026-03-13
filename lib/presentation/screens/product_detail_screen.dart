import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/formatters.dart';
import '../../routes/app_routes.dart';
import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';
import '../widgets/rating_stars.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().products;
    final product =
        products.firstWhere((element) => element.id == productId);
    final cart = context.watch<CartProvider>();
    final qty = cart.quantityForProduct(product.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: product.imagePath.isEmpty
                  ? Container(
                      width: double.infinity,
                      height: 220,
                      color: Colors.brown.shade200,
                      child: const Center(
                        child: Icon(
                          Icons.local_cafe,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Image.asset(
                      product.imagePath,
                      width: double.infinity,
                      height: 220,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(height: 16),
            Text(
              product.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            RatingStars(rating: product.rating),
            const SizedBox(height: 8),
            Text(
              Formatters.price(product.price),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text(
              product.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: qty > 0
                        ? () =>
                            cart.updateQuantity(product.id, qty - 1)
                        : null,
                  ),
                  Text(
                    '$qty',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () =>
                        cart.updateQuantity(product.id, qty + 1),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  final shouldContinue = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirm purchase?'),
                      content: const Text(
                        'Do you want to proceed to buy this item? You can withdraw if you change your mind.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Navigator.of(context).pop(false),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              Navigator.of(context).pop(true),
                          child: const Text('Continue'),
                        ),
                      ],
                    ),
                  );
                  if (shouldContinue == true && context.mounted) {
                    Navigator.of(context).pushNamed(AppRoutes.checkout);
                  }
                },
                icon: const Icon(Icons.monetization_on_outlined),
                label: const Text('Buy Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


