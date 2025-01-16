import 'package:flutter/material.dart';
import 'package:patch_assesment/home/model/product.dart';
import 'package:patch_assesment/home/model/services/product_service.dart';

class ProductsViewModel extends ChangeNotifier {
     List<Product> products =[];
// Get products
  Future<List<Product>> getProducts() async {
   products = await ProductService().getProducts();
    notifyListeners();
    return products;
  }
}
