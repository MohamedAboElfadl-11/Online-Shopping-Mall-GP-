import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:start_project/chat_screens/chats_screen.dart';
import 'AddProduct.dart';
import 'brandProfile-brandView.dart';
import 'dashboard.dart';
import 'order.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Page',
      theme: ThemeData(
        primaryColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      home: ProductPage(),
    );
  }
}

class Product {
  final String name;
  final String stockStatus;
  final String price;

  Product({required this.name, required this.stockStatus, required this.price});
}

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List<Product> allProducts = [
    Product(name: 'Tote Bag', stockStatus: '10 in Stock', price: 'EGP310'),
    Product(name: 'Tote Bag', stockStatus: 'Out of Stock', price: 'EGP310'),
    Product(name: 'Tote Bag', stockStatus: '10 in Stock', price: 'EGP310'),
    Product(name: 'Tote Bag', stockStatus: 'Out of Stock', price: 'EGP310'),
    Product(name: 'Tote Bag', stockStatus: '2 in Stock', price: 'EGP310'),
  ];

  List<Product> displayedProducts = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayedProducts = List.from(allProducts);
  }

  void _filterProducts(String query) {
    List<Product> filteredProducts = allProducts
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      displayedProducts = filteredProducts;
    });
  }

  void _openAddProductPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddProductScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF684399),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search, color: Colors.black),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                          fontSize: 14, color: Color(0xFF684399)),
                      onChanged: _filterProducts,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Color(0xFF684399)),
                  onPressed: _openAddProductPage,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedProducts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset('images/image-not-found.jpg',
                      width: 50, height: 50),
                  title: Text(displayedProducts[index].name),
                  subtitle: Text(displayedProducts[index].stockStatus),
                  trailing: Text(displayedProducts[index].price),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 1.0)),
        ),
        child: SalomonBottomBar(
          currentIndex: 3, // Set the correct index for the current page
          backgroundColor: Colors.white,
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardScreen()),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrdersPage()),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatsScreen()),
                ); // Add navigation logic for Messages page if you have one
                break;
              case 3:
                // Already on the Products page, no action needed
                break;
              case 4:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
            }
          },
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.dashboard),
              title: const Text("Dashboard"),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.receipt_long),
              title: const Text("Orders"),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.message),
              title: const Text("Message"),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.inventory_2, color: Color(0xFF684399)),
              title: const Text("Products",
                  style: TextStyle(color: Color(0xFF684399))),
            ),
            SalomonBottomBarItem(
              icon: const Icon(
                Icons.account_circle,
              ),
              title: const Text(
                "Account",
                style: TextStyle(color: Color(0xFF684399)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
