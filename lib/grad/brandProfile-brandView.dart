import 'package:flutter/material.dart';
import 'package:start_project/chat_screens/chats_screen.dart';
import 'package:start_project/grad/product.dart';
import 'createBrandProfile.dart';
import 'package:share/share.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'dashboard.dart';
import 'order.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
    );
  }
}

class Product {
  final String name;
  final String image;
  final double price;

  Product({
    required this.name,
    required this.image,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      image: json['image'],
      price: json['price'].toDouble(),
    );
  }
}

class BrandProfile {
  final String name;
  final String category;
  final int followers;
  final String description;
  final String coverImage;
  final String profileImage;

  BrandProfile({
    required this.name,
    required this.category,
    required this.followers,
    required this.description,
    required this.coverImage,
    required this.profileImage,
  });

  factory BrandProfile.fromJson(Map<String, dynamic> json) {
    return BrandProfile(
      name: json['name'],
      category: json['category'],
      followers: json['followers'],
      description: json['description'],
      coverImage: json['coverImage'],
      profileImage: json['profileImage'],
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<BrandProfile> brandProfile;
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    brandProfile = fetchBrandProfile();
    products = fetchProducts();
  }

  Future<BrandProfile> fetchBrandProfile() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Hypothetical data
    return BrandProfile(
      name: 'Brand Name',
      category: 'Brand Category',
      followers: 1234,
      description: 'This is a description of the brand.',
      coverImage: 'https://via.placeholder.com/600x160',
      profileImage: 'https://via.placeholder.com/150',
    );
  }

  Future<List<Product>> fetchProducts() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Hypothetical data
    return [
      Product(
          name: 'Product 1',
          image: 'https://via.placeholder.com/150',
          price: 100.0),
      Product(
          name: 'Product 2',
          image: 'https://via.placeholder.com/150',
          price: 200.0),
      Product(
          name: 'Product 3',
          image: 'https://via.placeholder.com/150',
          price: 300.0),
      Product(
          name: 'Product 4',
          image: 'https://via.placeholder.com/150',
          price: 400.0),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<BrandProfile>(
              future: brandProfile,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Failed to load profile'));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('No profile data'));
                } else {
                  final profile = snapshot.data!;
                  return Column(
                    children: [
                      Container(
                        height: 260.0,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Container(
                              height: 160.0,
                              width: double.infinity,
                              child: Image.network(
                                profile.coverImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 105.0,
                              left: 12,
                              right: 0,
                              child: Center(
                                child: CircleAvatar(
                                  radius: 75.0,
                                  backgroundImage:
                                      NetworkImage(profile.profileImage),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            Text(
                              profile.name,
                              style: const TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  profile.category,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                                const SizedBox(width: 18.0),
                                Text(
                                  '${profile.followers} Followers',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              profile.description,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CreateBrandProfile()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(150, 37),
                                backgroundColor: const Color(0xFF684399),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                              child: const Text(
                                'Edit Profile',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Share.share(
                                  'Check out this amazing profile: ${profile.name}\n${profile.category}\n${profile.followers} Followers\n${profile.description}',
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF684399),
                                minimumSize: const Size(150, 37),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                              child: const Text(
                                'Share Profile',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 20.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Products',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  FutureBuilder<List<Product>>(
                    future: products,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(
                            child: Text('Failed to load products'));
                      } else if (!snapshot.hasData) {
                        return const Center(
                            child: Text('No products available'));
                      } else {
                        final productData = snapshot.data!;
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemCount: productData.length,
                          itemBuilder: (context, index) {
                            final product = productData[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 110,
                                    width: double.infinity,
                                    child: Center(
                                      child: Image.network(
                                        product.image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'EGP ${product.price}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF684399),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 1.0)),
        ),
        child: SalomonBottomBar(
          currentIndex: 4,
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
                );
                // Add navigation logic for Messages page if you have one
                break;
              case 3:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductPage()),
                );
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
              title: const Text("Search"),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.message),
              title: const Text("Message"),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.inventory_2),
              title: const Text("Cart"),
            ),
            SalomonBottomBarItem(
              icon: const Icon(
                Icons.account_circle,
                color: Color(0xFF684399),
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
