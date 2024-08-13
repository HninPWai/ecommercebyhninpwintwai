import 'package:flutter/material.dart';
import '../../data/vos/product_vo.dart';
import '../item_views/product_item_view.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductVO> products;

  ProductGrid({required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
      ),
      itemBuilder: (context, index) {
        return ProductItemView(product: products[index]);
      },
    );
  }
}
