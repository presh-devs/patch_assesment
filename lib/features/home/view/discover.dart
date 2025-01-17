import 'package:flutter/material.dart';
import 'package:patch_assesment/features/home/model/category.dart';
import 'package:patch_assesment/features/home/model/product.dart';
import 'package:patch_assesment/features/home/view_model/products_view_model.dart';
import 'package:patch_assesment/widgets/sort_button.dart';
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
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.sizeOf(context).width, 70),
        child: Container(
          height: 60,
          color: const Color(0xFF7A6EAE),
        ),
      ),
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          const SliverAppBar(
            backgroundColor: Color(0xFF7A6EAE),
            expandedHeight: 10,
          ),
          SliverPersistentHeader(
              delegate: HomeAppBarDelegate(expandedHeight: 100)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              child: FutureBuilder<List<Product>>(
                future: _productsFuture,
                builder: (context, productSnapshot) {
                  if (productSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  } else if (productSnapshot.hasError) {
                    return Center(
                        child: Text('Error: ${productSnapshot.error}'));
                  } else if (!productSnapshot.hasData ||
                      productSnapshot.data!.isEmpty) {
                    return const Center(child: Text('No products found.'));
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Choose from any category',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      FutureBuilder<List<ProductCategory>>(
                        future: _categoriesFuture,
                        builder: (context, categorySnapshot) {
                          if (categorySnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator.adaptive());
                          } else if (categorySnapshot.hasError) {
                            return Center(
                                child:
                                    Text('Error: ${categorySnapshot.error}'));
                          } else if (!categorySnapshot.hasData ||
                              categorySnapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('No categories found.'));
                          }

                          final categories = categorySnapshot.data!;
                          return SizedBox(
                            height: 120,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                const itemWidth = 80.0;
                                final spacing = (constraints.maxWidth -
                                        (itemWidth * categories.length)) /
                                    (categories.length + 1);

                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: categories.length,
                                  itemBuilder: (context, index) {
                                    final category = categories[index];
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        left:
                                            index == 0 ? spacing : spacing / 2,
                                        right: index == categories.length - 1
                                            ? spacing
                                            : spacing / 2,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          viewModel
                                              .filterProducts(category.name);

                                          setState(() {});
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(1),
                                              width: itemWidth,
                                              height: itemWidth,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                border: viewModel
                                                            .currentCategory ==
                                                        category.name
                                                    ? Border.all(
                                                        color: const Color(
                                                            0xFF75D08F),
                                                        width: viewModel
                                                                    .currentCategory ==
                                                                category.name
                                                            ? 2.0
                                                            : 0,
                                                      )
                                                    : const Border(),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                child: Image.asset(
                                                  viewModel.getCategoryImage(
                                                      category.name),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              viewModel.getCategoryText(
                                                  category.name),
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        viewModel.filteredProducts.isNotEmpty
                            ? "${viewModel.filteredProducts.length} products to choose from"
                            : "${viewModel.allProducts.length} products to choose from",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          SortButton(
                            viewModel: viewModel,
                            title: 'Lowest price first',
                            onPressed: () => viewModel.sortAscending(),
                          ),
                          const SizedBox(width: 16),
                          SortButton(
                            viewModel: viewModel,
                            title: 'Highest price first',
                            onPressed: () => viewModel.sortDescending(),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: viewModel.filteredProducts.isNotEmpty
                            ? viewModel.filteredProducts.length
                            : viewModel.allProducts.length,
                        itemBuilder: (context, index) {
                          final productList =
                              viewModel.filteredProducts.isNotEmpty
                                  ? viewModel.filteredProducts
                                  : viewModel.allProducts;

                          final product = productList[index];
                          return Container(
                            padding: const EdgeInsets.all(8.0),
                            width: 170,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xFFCACACA), width: 0.5),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Center(
                                  child: SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Image.network(
                                      product.image,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                Text(
                                  product.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                ),
                                Text(
                                  product.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                      color: Color(0xFF7C7C7C)),
                                ),
                                Text(
                                  "\$${product.price.toString()}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                              child: Text(
                            'That\'s all!',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color(0xFF7C7C7C)),
                          ))),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  HomeAppBarDelegate({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF7A6EAE), Colors.white],
              stops: [0.5, 0.5],
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: 20,
          right: 20,
          child: Opacity(
            opacity: disappear(shrinkOffset),
            child: Material(
              elevation: 5,
              color: Colors.transparent,
              shadowColor: const Color(0xFFBEBEC1),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  hintText: 'What are you looking for?',
                  hintStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF717171)),
                  prefixIcon:
                      const Icon(Icons.search, color: Color(0xFF717171)),
                  fillColor: const Color(0xFFFFFFFF),
                  filled: true,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
