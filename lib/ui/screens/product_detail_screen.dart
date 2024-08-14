import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productName;
  final String price;
  final String imageUrl;
  final String rating;
  final String description;
  final String category;
  final String deliveryNote;

  ProductDetailScreen({
    required this.productName,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.description,
    required this.category,
    required this.deliveryNote,
  });

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int selectedSize = 0;
  int selectedColor = 0;
  int quantity = 1;
  bool isDescriptionExpanded = false;
  bool isDeliveryExpanded = false;

  final List<String> sizes = ["5", "5.5", "6", "6.5", "7"];
  final List<Color> colors = [Colors.white,Colors.black, Colors.green, Colors.purple];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite,color: Colors.orange),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            Center(
              child: Image.network(
                widget.imageUrl,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.category,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.grey),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange),
                      Text('(${widget.rating.toString()})',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.productName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    widget.price.toString(),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Size:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "US UK EU",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: List.generate(sizes.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSize = index;
                      });
                    },
                    child: Container(
                      width: 50,
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        color: selectedSize == index
                            ? Colors.orange
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Text(
                          sizes[index],
                          style: TextStyle(
                            fontSize: 16,
                            color: selectedSize == index
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionPanelList(
                elevation: 1,
                expandedHeaderPadding: EdgeInsets.zero,
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    if (index == 0) isDescriptionExpanded = !isDescriptionExpanded;
                    if (index == 1) isDeliveryExpanded = !isDeliveryExpanded;
                  });
                },
                children: [
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return const ListTile(
                        title: Text("Description",style: TextStyle(fontWeight: FontWeight.w500),),
                      );
                    },
                    body: ListTile(
                      title: Text(widget.description),
                    ),
                    isExpanded: isDescriptionExpanded,
                  ),
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return const ListTile(
                        title: Text("Free Delivery and Returns",style: TextStyle(fontWeight: FontWeight.w500),),
                      );
                    },
                    body:  ListTile(
                      title: Text(widget.deliveryNote),
                    ),
                    isExpanded: isDeliveryExpanded,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Color:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: List.generate(colors.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: colors[index],
                              border: selectedColor == index
                                  ? Border.all(color: Colors.orange, width: 2)
                                  : null,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: 40,
                            height: 40,
                          ),
                          if (selectedColor == index)
                            const Icon(
                              Icons.check,
                              color: Colors.orange,
                              size: 24, // Adjust size as needed
                            ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Quantity:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                      ),
                      Text(
                        quantity.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Add to Cart',
                    style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ),
            ),
            const SizedBox(height: 20,)

          ],
        ),
      ),
    );
  }
}
