import 'package:flutter/material.dart';
import '../../data/vos/product_vo.dart';
import '../item_views/product_item_view.dart';

class ProductList extends StatelessWidget {
  final List<ProductVO> products;

  ProductList({required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 / 4,
      ),
      itemBuilder: (context, index) {
        return ProductItemView(product: products[index]);
      },
    );
    // return ListView.builder(
    //   itemCount: products.length,
    //   itemBuilder: (context, index) {
    //     return ProductItemView(product: products[index]);
    //   },
    // );
  }
}
