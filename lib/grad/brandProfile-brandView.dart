import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:start_project/chat_screens/chats_screen.dart';
import 'package:start_project/grad/product.dart';
import 'logo.dart';
import 'product_provider.dart';
import 'package:share/share.dart';
import 'dashboard.dart';
import 'order.dart';
import 'createBrandProfile.dart';

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
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<BrandProfile> brandProfile;

  @override
  void initState() {
    super.initState();
    brandProfile = fetchBrandProfile();
  }

  Future<BrandProfile> fetchBrandProfile() async {
    await Future.delayed(Duration(seconds: 0)); // Simulate network delay
    return BrandProfile(
      name: 'Brand Name',
      category: 'Brand Category',
      followers: 1234,
      description: 'This is a description of the brand.',
      coverImage: 'https://via.placeholder.com/600x160',
      profileImage: 'https://via.placeholder.com/150',
    );
  }

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => WelcomeScreen()),
          (Route<dynamic> route) => false,
    );
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
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Failed to load profile'));
                } else if (!snapshot.hasData) {
                  return Center(child: Text('No profile data'));
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
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  profile.category,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                                SizedBox(width: 18.0),
                                Text(
                                  '${profile.followers} Followers',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              profile.description,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10.0),
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
                                    builder: (context) => CreateBrandProfile(),
                                  ),
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
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Products',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Consumer<ProductProvider>(
                    builder: (context, productProvider, child) {
                      return productProvider.products.isEmpty
                          ? Center(
                        child: Text(
                          'No Products Added Yet',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                          : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: productProvider.products.length,
                        itemBuilder: (context, index) {
                          final product = productProvider.products[index];
                          return ListTile(
                            leading: Image.file(
                              product.imageFile,
                              width: 50,
                              height: 50,
                            ),
                            title: Text(product.name),
                            subtitle: Text(product.stockStatus),
                            trailing: Text('\$${product.price.toStringAsFixed(2)}'),
                          );
                        },
                      );
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
                break;
              case 3:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductPage()),
                );
                break;
              case 4:
                break;
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
              icon: const Icon(Icons.inventory_2),
              title: const Text("Products"),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.account_circle, color: Color(0xFF684399)),
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
