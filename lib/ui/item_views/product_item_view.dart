import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../data/vos/product_vo.dart';
import '../screens/product_detail_screen.dart';

class ProductItemView extends StatefulWidget {
  const ProductItemView({super.key,required this.product});

  final ProductVO? product;

  @override
  _ProductItemViewState createState() => _ProductItemViewState();
}

class _ProductItemViewState extends State<ProductItemView> {

  bool isFavorite = true;

  @override
  Widget build(BuildContext context) {
    if (widget.product == null) {
      return const SizedBox();
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              productName: widget.product!.name ?? 'Unknown',
              price: widget.product!.price ?? 'Unknown',
              imageUrl: widget.product!.imageUrl ?? '',
              rating: widget.product!.rating ?? '',
              description: widget.product!.description ?? '',
              category: widget.product!.category ?? '',
              deliveryNote: widget.product!.deliveryNote ?? '',
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Center(
                    child: widget.product!.imageUrl != null
                        ? Image.network(
                      widget.product!.imageUrl!,
                      height: 150,
                      fit: BoxFit.cover,
                    )
                        : const SizedBox(),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.orange,
                    ),
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                  ),
                ),

                Positioned(
                  top: 10,
                  left: 10,
                  child: Text(
                    widget.product!.price ?? 'Unknown',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.product!.name ?? 'Unknown',
                      style: const TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
                      onPressed: () {
                        Fluttertoast.showToast(msg: 'Adding to the shopping cart.');
                      },
                    ),
                  ),
                ],
              ),
            )


          ],
        ),
      ),
    );
  }
}
