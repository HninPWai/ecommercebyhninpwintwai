import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../data/vos/product_vo.dart';
import '../screens/product_detail_screen.dart';

class ProductItemView extends StatelessWidget {
  final ProductVO? product;

  ProductItemView({required this.product});

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return const SizedBox(); // Return an empty widget if product is null
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              productName: product!.name ?? 'Unknown',
              price: product!.price ?? 'Unknown',
              imageUrl: product!.imageUrl ?? '',
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Center(
                  child: product!.imageUrl != null
                      ? Image.network(
                    product!.imageUrl!,
                    height: 150,
                    fit: BoxFit.cover,
                  )
                      : const SizedBox(),
                ),
                const Positioned(
                  top: 10,
                  right: 10,
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Text(
                    product!.price ?? 'Unknown',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  product!.name ?? 'Unknown',
                  style: const TextStyle(fontSize: 16),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: const Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      Fluttertoast.showToast(msg: 'Adding to the shopping cart.');
                    },
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
