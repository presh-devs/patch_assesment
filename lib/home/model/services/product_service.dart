import 'package:patch_assesment/home/model/product.dart';
import 'package:patch_assesment/home/model/services/api_service.dart';

class ProductService {
  final ApiService _apiService = ApiService();

  // Get products
  Future<List<Product>> getProducts() async {
    final response = await _apiService.getResponse('/products');
 
    if (response != null) {
      return (response as List).map((e) => Product.fromJson(e)).toList();
    
    }
    return [];
  }
}
