import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:ionicons/ionicons.dart';

import '../constants.dart';
import '../widgets/categories.dart';
import '../models/products.dart';
import '../widgets/home_slider.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';
import 'favorite_screen.dart';
import 'messages_screen.dart';

class HomeScreen extends StatefulWidget {
  final String brandName;
  final String phone;
  final String email;
  const HomeScreen(
      {Key? key,
      required this.brandName,
      required this.phone,
      required this.email})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.brandName),
        backgroundColor: Colors.deepPurple,
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(widget.phone),
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.email),
                    title: Text(widget.email),
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.share),
                    title: Text('Share'),
                    onTap: () async {
                      await FlutterShare.share(
                        title: 'Share Brand',
                        text: 'Check out this brand: ${widget.brandName}',
                        linkUrl: 'https://example.com',
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      backgroundColor: kscaffoldColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: HomeSlider(
                      images: [
                        "images/image-not-found.jpg",
                        "images/image-not-found.jpg",
                        "images/image-not-found.jpg",
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Categories(),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Special For You",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ListTile(
                                  title: Text('All Products'),
                                  trailing: IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: products.length,
                                    itemBuilder: (context, index) {
                                      return ProductCard(
                                          product1: products[index]);
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text(
                        "See all",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product1: products[index]);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Ensure all items are displayed
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor:
            Colors.grey, // Set a different color for unselected items
        currentIndex: currentTab,
        onTap: (int index) {
          setState(() {
            currentTab = index;
            switch (index) {
              case 0:
                Navigator.of(context).popUntil((route) => route.isFirst);
                break;
              case 1:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FavoritePage()));
                break;
              case 2:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
                break;
              case 3:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Messages()));
                break;
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Ionicons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.heart_sharp),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.cart_outline),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            label: 'Messages',
          ),
        ],
      ),
    );
  }
}
