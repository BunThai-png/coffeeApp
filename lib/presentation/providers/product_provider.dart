import 'package:flutter/material.dart';

import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';

class ProductProvider extends ChangeNotifier {
  ProductProvider(this._repository) {
    loadProducts();
  }

  final ProductRepository _repository;

  List<ProductModel> _products = <ProductModel>[];
  bool _loading = false;

  List<ProductModel> get products => _products;
  bool get isLoading => _loading;

  Future<void> loadProducts() async {
    _loading = true;
    notifyListeners();
    _products = await _repository.getProducts();
    _loading = false;
    notifyListeners();
  }

  List<ProductModel> byCategory(String category) {
    return _products.where((p) => p.category == category).toList();
  }
}



