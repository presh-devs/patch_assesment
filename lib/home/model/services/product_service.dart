import 'package:flutter/foundation.dart';
import 'package:patch_assesment/home/model/category.dart';
import 'package:patch_assesment/home/model/product.dart';
import 'package:patch_assesment/home/model/services/api_service.dart';

class ProductService {
  final ApiService _apiService = ApiService();

  // Get products
  Future<List<Product>> getProducts() async {
    final response = await _apiService.getResponse('/products', limit: 50);

    if (response != null) {
      return (response as List).map((e) => Product.fromJson(e)).toList();
    }
    return [];
  }

  // Get categories
  Future<List<ProductCategory>> getCategories() async {
    final response = await _apiService.getResponse(
      '/products/categories',
    );

    if (response != null) {
      return (response as List)
          .map((e) => ProductCategory.fromJson(e))
          .toList();
    }
    return [];
  }
}
