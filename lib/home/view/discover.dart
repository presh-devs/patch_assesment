import 'package:flutter/material.dart';
import 'package:patch_assesment/home/model/category.dart';
import 'package:patch_assesment/home/model/product.dart';
import 'package:patch_assesment/home/view_model/products_view_model.dart';
import 'package:provider/provider.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  late Future<List<Product>> _productsFuture;
  late Future<List<ProductCategory>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    final viewModel = context.read<ProductsViewModel>();
    _productsFuture = viewModel.getProducts(); // Initialize only once
    _categoriesFuture = viewModel.getCategories(); // Initialize only once
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProductsViewModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7A6EAE),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          await viewModel.getProducts(); // Explicitly refresh products
          setState(() {
            _productsFuture =
                viewModel.getProducts(); // Update future for refresh
          });
        },
        child: FutureBuilder<List<Product>>(
          future: _productsFuture,
          builder: (context, productSnapshot) {
            if (productSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (productSnapshot.hasError) {
              return Center(child: Text('Error: ${productSnapshot.error}'));
            } else if (!productSnapshot.hasData ||
                productSnapshot.data!.isEmpty) {
              return const Center(child: Text('No products found.'));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<List<ProductCategory>>(
                  future: _categoriesFuture,
                  builder: (context, categorySnapshot) {
                    if (categorySnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator.adaptive());
                    } else if (categorySnapshot.hasError) {
                      return Center(
                          child: Text('Error: ${categorySnapshot.error}'));
                    } else if (!categorySnapshot.hasData ||
                        categorySnapshot.data!.isEmpty) {
                      return const Center(child: Text('No categories found.'));
                    }

                    final categories = categorySnapshot.data!;
                    return SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return GestureDetector(
                            onTap: () {
                              viewModel.filterProducts(category.name);
                              setState(
                                  () {}); // Trigger rebuild to reflect filtered products
                            },
                            child: CircleAvatar(
                              radius: 50,
                              child: Text(category.name),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        viewModel.sortAscending();
                      },
                      child: const Text('Sort Ascending'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        viewModel.sortDescending();
                      },
                      child: const Text('Sort Descending'),
                    ),
                  ],
                ),
                Text(viewModel.filteredProducts.isNotEmpty
                    ? "${viewModel.filteredProducts.length} products to choose from"
                    : "${viewModel.allProducts.length} prodcuts to choose from"),
                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.filteredProducts.isNotEmpty
                        ? viewModel.filteredProducts.length
                        : viewModel.allProducts.length,
                    itemBuilder: (context, index) {
                      final product = viewModel.filteredProducts.isNotEmpty
                          ? viewModel.filteredProducts[index]
                          : viewModel.allProducts[index];
                      return ListTile(
                        title: Text(product.price.toString()),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
