import '../api/api_client.dart';
import '../models/product_model.dart';

class ProductService {
  ProductService({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  final ApiClient _apiClient;

  Future<List<ProductModel>> fetchProducts() async {
    return _apiClient.simulateRequest(() {
      // Mock products
      return <ProductModel>[
        ProductModel(
          id: '1',
          name: 'Latte',
          description: 'Best Coffee',
          price: 30,
          imagePath: '',
          rating: 4.8,
          category: 'hot',
        ),
        ProductModel(
          id: '2',
          name: 'Espresso',
          description: 'Strong and bold',
          price: 30,
          imagePath: '',
          rating: 4.7,
          category: 'hot',
        ),
        ProductModel(
          id: '3',
          name: 'Black Coffee',
          description: 'Classic brew',
          price: 30,
          imagePath: '',
          rating: 4.6,
          category: 'hot',
        ),
        ProductModel(
          id: '4',
          name: 'Iced Latte',
          description: 'Cold and refreshing',
          price: 30,
          imagePath: '',
          rating: 4.9,
          category: 'cold',
        ),
      ];
    });
  }
}


