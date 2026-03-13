import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductRepository {
  ProductRepository(this._service);

  final ProductService _service;

  Future<List<ProductModel>> getProducts() {
    return _service.fetchProducts();
  }
}


