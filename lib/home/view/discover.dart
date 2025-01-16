import 'package:flutter/material.dart';
import 'package:patch_assesment/home/model/product.dart';
import 'package:patch_assesment/home/view_model/products_view_model.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ProductsViewModel();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7A6EAE),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () => viewModel.getProducts(),
        child: FutureBuilder<List<Product>>(
          future: viewModel.getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No products found.'));
            }

            final products = snapshot.data!;

            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product.title),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
