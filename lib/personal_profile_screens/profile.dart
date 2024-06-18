import 'package:flutter/material.dart';
import 'package:start_project/personal_profile_screens/shippingAddress.dart';
import '../chat_screens/chats_screen.dart';
import '../personal_profile_screens/category_profile.dart';
import '../setting_screen/screens/settings_screen.dart';
import 'myOrders.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xFF684399),
                  backgroundImage: AssetImage(
                    'images/image-not-found.jpg',
                  ),
                  radius: 50.0,
                ),
                SizedBox(width: 20.0),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User Name',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        'username@gmail.com',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // تحسين الكود باستخدام InkWell
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatsScreen()),
              );
            },
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: category(
                  text: 'My Chats',
                  text1: '2 chats',
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyOrdersPage()),
              );
            },
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: category(
                  text: 'My orders',
                  text1: 'Already have 10 orders',
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShippingAddressPage()),
              );
            },
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: category(
                  text: 'Shipping Addresses',
                  text1: '03 Addresses',
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: category(
                  text: 'Setting',
                  text1: 'Notification, Password, FAQ, Contact',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
