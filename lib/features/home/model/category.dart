class ProductCategory {
  final String name;

  const ProductCategory({required this.name});

  factory ProductCategory.fromJson(String json) {
    return ProductCategory(
      name: json,
    );
  }


  @override
  String toString() => 'ProductCategory(name: \$name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductCategory && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

