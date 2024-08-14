import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../constants/app_constants.dart';
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
    'assets/images/nike.jpeg',
    'assets/images/adidas.png',
    'assets/images/puma.jpg',
    'assets/images/underarmour.png',
    'assets/images/newbalance.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined),
            onPressed: () {
              Fluttertoast.showToast(msg: 'Clicked the shopping cart.');
            },
          ),
        ],
      ),
      drawer: const NavigationDrawer(children: [],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 10.0),
        child: Column(
          children: [
            /// Search
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
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
                height: 60.0,
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
                const Text('Popular',style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                const Spacer(),
                IconButton(
                  icon: Icon(isGridView ? Icons.grid_view : Icons.list),
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
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,
        selectedItemColor: AppConstants.primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
        ],
      ),
    );
  }
}
