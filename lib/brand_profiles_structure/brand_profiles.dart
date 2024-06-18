import 'package:flutter/material.dart';
import 'package:start_project/brand_profiles_structure/top_brands.dart';
import '../brand_profile_pages/screens/Notifications.dart';
import 'brand_profile_class.dart';
import 'following_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<BrandProfile> _brandProfiles = [
    BrandProfile(
      logo: "images/image-not-found.jpg",
      brandName: "Handmade",
      username: "Fatma Muhammad",
      email: "fatma@gmail.com",
      address: "Zamalek",
      phone: "01221515704",
      item: "Tote Bag",
      description:
          "Hello HelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHello",
      rate: 100,
    ),
    BrandProfile(
      logo: "images/image-not-found.jpg",
      brandName: "Fashion",
      username: "Fatma Muhammad",
      email: "fatma@gmail.com",
      address: "Zamalek",
      phone: "01221515704",
      item: "Woman Sweater",
      description:
          "Hello HelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHello",
      rate: 350,
    ),
    BrandProfile(
      logo: "images/image-not-found.jpg",
      brandName: "Jewellery",
      username: "Fatma Muhammad",
      email: "fatma@gmail.com",
      address: "Zamalek",
      phone: "01221515704",
      item: "Accessories",
      description: "Hello",
      rate: 1000,
    ),
  ];

  String _searchQuery = '';
  late List<BrandProfile> _searchResults;

  @override
  void initState() {
    super.initState();
    _searchResults = _brandProfiles;
  }

  void _search(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      _searchResults = _brandProfiles.where((profile) {
        final productName = profile.item.toLowerCase();
        return productName.contains(_searchQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'SHOPY',
          style: TextStyle(
            fontSize: 32.0,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyNotificationScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.notifications,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Container(
                //   height: 140,
                //   width: double.infinity,
                //   color: Colors.deepPurple,
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(15),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Row(
                    //         children: [
                    //           Container(
                    //             alignment: Alignment.topLeft,
                    //             height: 45,
                    //             width: 45,
                    //           ),
                    //           const SizedBox(width: 10),
                    //         ],
                    //       ),
                    //       GestureDetector(
                    //         onTap: () {
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //               builder: (context) =>
                    //                   MyNotificationScreen(),
                    //             ),
                    //           );
                    //         },
                    //         child: Container(
                    //             alignment: Alignment.topRight,
                    //             child: const Icon(
                    //               Icons.notifications,
                    //               color: Colors.white,
                    //               size: 30,
                    //             )),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F7),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextField(
                          cursorHeight: 20,
                          autofocus: false,
                          onChanged: _search,
                          decoration: InputDecoration(
                            hintText: "Search...",
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FollowingPage(
                                  followedBrands: BrandProfile.followedBrands,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.deepPurple.shade200,
                                  //boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 3)],
                                ),
                                child: const Icon(
                                  Icons.favorite,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Following Brands"
                                "",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TopBrands(),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.deepPurple.shade200,
                                  //boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 3)],
                                ),
                                child: const Icon(
                                  Icons.star,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Top Brands",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "Local Brands",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              children: _searchResults
                  .map((profile) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: profile,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
