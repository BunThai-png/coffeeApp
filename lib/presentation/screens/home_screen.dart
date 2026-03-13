import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_strings.dart';
import '../../data/models/product_model.dart';
import '../../routes/app_routes.dart';
import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _category = 'hot';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<ProductModel> _filterProducts(List<ProductModel> products) {
    final query = _searchCtrl.text.trim().toLowerCase();
    if (query.isEmpty) return products;
    return products
        .where((p) => p.name.toLowerCase().contains(query))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    final cart = context.watch<CartProvider>();

    final hot = _filterProducts(productProvider.byCategory('hot'));
    final cold = _filterProducts(productProvider.byCategory('cold'));
    final cappuccino = _filterProducts(productProvider.byCategory('cappuccino'));

    List<ProductModel> current;
    if (_category == 'hot') {
      current = hot;
    } else if (_category == 'cold') {
      current = cold;
    } else {
      current = cappuccino;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: const Text("It's a Great Day for Coffee"),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _searchCtrl,
                decoration: InputDecoration(
                  hintText: AppStrings.searchCoffee,
                  prefixIcon: const Icon(Icons.search),
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _categoryChip(
                    label: AppStrings.hotCoffee,
                    value: 'hot',
                  ),
                  _categoryChip(
                    label: AppStrings.coldCoffee,
                    value: 'cold',
                  ),
                  _categoryChip(
                    label: AppStrings.cappuccino,
                    value: 'cappuccino',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: productProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: current.length,
                        itemBuilder: (context, index) {
                          final product = current[index];
                          return ProductCard(
                            product: product,
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                AppRoutes.productDetail,
                                arguments: product.id,
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.of(context).pushNamed(AppRoutes.cart);
          } else if (index == 2) {
            Navigator.of(context).pushNamed(AppRoutes.profile);
          }
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart_outlined),
                if (cart.items.isNotEmpty)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${cart.items.length}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            label: AppStrings.cart,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: AppStrings.profile,
          ),
        ],
      ),
    );
  }

  Widget _categoryChip({required String label, required String value}) {
    final selected = _category == value;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) {
        setState(() {
          _category = value;
        });
      },
    );
  }
}


