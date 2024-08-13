import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../data/vos/product_vo.dart';
import '../../network/data_agent/firebase_data_agent.dart';
import '../widgets/product_grid.dart';
import '../widgets/product_list.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final FirebaseDataAgent _dataAgent = FirebaseDataAgent();
  bool isGridView = false;
  String searchQuery = '';
  final List<String> brandLogos = [
    'assets/nike.jpeg',
    'assets/adidas.png',
    'assets/puma.jpg',
    'assets/underarmour.png',
    'assets/newbalance.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(

          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
          decoration: const InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Fluttertoast.showToast(msg: 'Clicked the shopping cart.');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            /// Search
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                ),
              ),
            ),

            CarouselSlider(
              options: CarouselOptions(
                height: 70.0,
                enableInfiniteScroll: false,
                viewportFraction: 0.3,
                initialPage: 0,
                padEnds: false,
                scrollDirection: Axis.horizontal,
              ),
              items: brandLogos.map((logo) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(logo),
                    );
                  },
                );
              }).toList(),
            ),
            Row(
              children: [
                const Text('Popular'),
                const Spacer(),
                IconButton(
                  icon: Icon(isGridView ? Icons.list : Icons.grid_view),
                  onPressed: () {
                    setState(() {
                      isGridView = !isGridView;
                    });
                  },
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder<List<ProductVO>>(
                future: _dataAgent.fetchProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No products found.'));
                  } else {
                    List<ProductVO> filteredProducts = snapshot.data!
                        .where((product) =>
                        product.name.toLowerCase().contains(searchQuery.toLowerCase()))
                        .toList();

                    return isGridView
                        ? ProductGrid(products: filteredProducts)
                        : ProductList(products: filteredProducts);
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
