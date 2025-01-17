import 'package:flutter/material.dart';
import 'package:patch_assesment/core/constants/asset.dart';
import 'package:patch_assesment/features/home/model/category.dart';
import 'package:patch_assesment/features/home/model/product.dart';
import 'package:patch_assesment/features/home/model/services/product_service.dart';

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

  getCategoryImage(String category) {
    switch (category) {
      case 'jewelery':
        return AppAssets.jewelry;
      case 'electronics':
        return AppAssets.electronics;
      case "women's clothing":
        return AppAssets.womenClothing;
      case "men's clothing":
        return AppAssets.menClothing;
    }
  }

  getCategoryText(String category) {
    switch (category) {
      case 'jewelery':
        return "Jewelry";
      case 'electronics':
        return "Electronics";
      case "women's clothing":
        return "Women's Wear";
      case "men's clothing":
        return "Men's Wear";
    }
  }

// filter products
void filterProducts(String? category) {
  if (category == null ||
      category.isEmpty ||
      (filteredProducts.isNotEmpty &&
          filteredProducts.every((product) => product.category == category))) {
    // Reset to the original unfiltered list if the same category is selected
    filteredProducts = List.from(allProducts);
    currentCategory = null;
  } else {
    // Filter the products by category
    currentCategory = category;
    filteredProducts = allProducts
        .where((product) => product.category == category)
        .toList();
  }

  // Apply sorting if applicable
  applySorting();
  notifyListeners();
}

void sortAscending() {
  if (isSortedAscending) {
    // If already sorted ascending, revert to the original order
    isSortedAscending = false;
    isSortedDescending = false;
    resetToOriginalOrder();
  } else {
    // Sort the list in ascending order
    isSortedAscending = true;
    isSortedDescending = false;
    if (filteredProducts.isEmpty) {
      filteredProducts = List.from(allProducts);
    }
    filteredProducts.sort((a, b) => a.price.compareTo(b.price));
  }
  notifyListeners();
}

void sortDescending() {
  if (isSortedDescending) {
    // If already sorted descending, revert to the original order
    isSortedAscending = false;
    isSortedDescending = false;
    resetToOriginalOrder();
  } else {
    // Sort the list in descending order
    isSortedAscending = false;
    isSortedDescending = true;
    if (filteredProducts.isEmpty) {
      filteredProducts = List.from(allProducts);
    }
    filteredProducts.sort((a, b) => b.price.compareTo(a.price));
  }
  notifyListeners();
}

void resetToOriginalOrder() {
  if (currentCategory == null || currentCategory!.isEmpty) {
    // No category selected, reset to the original unfiltered list
    filteredProducts = List.from(allProducts);
  } else {
    // Reset to the filtered list for the current category
    filteredProducts = allProducts
        .where((product) => product.category == currentCategory)
        .toList();
  }
}

void applySorting() {
  // Reapply sorting if sorting flags are enabled
  if (isSortedAscending) {
    filteredProducts.sort((a, b) => a.price.compareTo(b.price));
  } else if (isSortedDescending) {
    filteredProducts.sort((a, b) => b.price.compareTo(a.price));
  }
}

}
