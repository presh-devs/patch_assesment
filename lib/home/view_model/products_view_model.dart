import 'package:flutter/material.dart';
import 'package:patch_assesment/home/model/category.dart';
import 'package:patch_assesment/home/model/product.dart';
import 'package:patch_assesment/home/model/services/product_service.dart';

class ProductsViewModel extends ChangeNotifier {
  final ProductService _productService = ProductService();
  List<Product> allProducts = [];
  List<Product> filteredProducts = [];
  bool isSortedAscending = false;
  bool isSortedDescending = false;
  String? currentCategory;

// Get products
  Future<List<Product>> getProducts() async {
    allProducts = await _productService.getProducts();

    notifyListeners();
    return allProducts;
  }

// Get categories
  Future<List<ProductCategory>> getCategories() async {
    final categories = await _productService.getCategories();

    notifyListeners();
    return categories;
  }
// Filter products
  void filterProducts(String? category) {
    currentCategory = category;

    if (category == null ||
        category.isEmpty ||
        (filteredProducts.isNotEmpty &&
            filteredProducts.first.category == category)) {
      filteredProducts = List.from(allProducts); // Reset to original list
    } else {
      filteredProducts =
          allProducts.where((element) => element.category == category).toList();
    }

    // Apply sorting if any
    if (isSortedAscending) {
      filteredProducts.sort((a, b) => a.price.compareTo(b.price));
    } else if (isSortedDescending) {
      filteredProducts.sort((a, b) => b.price.compareTo(a.price));
    }

    notifyListeners();
  }

  void sortAscending() {
    if (isSortedAscending) {
      // If already sorted ascending, revert to original list for current category
      isSortedAscending = false;
      isSortedDescending = false;
      resetToOriginalOrder();
    } else {
      isSortedAscending = true;
      isSortedDescending = false;
      filteredProducts.sort((a, b) => a.price.compareTo(b.price));
    }
    notifyListeners();
  }

  void sortDescending() {
    if (isSortedDescending) {
      // If already sorted descending, revert to original list for current category
      isSortedAscending = false;
      isSortedDescending = false;
      resetToOriginalOrder();
    } else {
      isSortedAscending = false;
      isSortedDescending = true;
      filteredProducts.sort((a, b) => b.price.compareTo(a.price));
    }
    notifyListeners();
  }

  void resetToOriginalOrder() {
    if (currentCategory == null || currentCategory!.isEmpty) {
      // No category selected, reset to all products
      filteredProducts = List.from(allProducts);
    } else {
      // Reset to filtered list for the current category
      filteredProducts = allProducts
          .where((product) => product.category == currentCategory)
          .toList();
    }
  }
}
