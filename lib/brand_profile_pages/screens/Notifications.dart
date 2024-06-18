import 'dart:math';
import 'package:flutter/material.dart';

import '../models/products.dart';

class MyNotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Text(
                'Notifications',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        body: ApplicationScreen(),
      ),
    );
  }
}

class ApplicationScreen extends StatefulWidget {
  @override
  _ApplicationScreenState createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  late Future<List<NotificationItem>> futureNotifications;

  @override
  void initState() {
    super.initState();
    futureNotifications = fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NotificationItem>>(
      future: futureNotifications,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: AssetImage(snapshot.data![index].product.image), // استخدام صور المنتجات من كلاس Product
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                snapshot.data![index].status,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                snapshot.data![index].description,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 16.0,
                    thickness: 1.0,
                  ),
                ],
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        }
        // By default, show a loading spinner
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<List<NotificationItem>> fetchNotifications() async {
    // Simulate fetching data from an API
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay

    final List<NotificationItem> notifications = [];

    for (int i = 0; i < 10; i++) {
      notifications.add(
        NotificationItem(
          product: products[Random().nextInt(products.length)], // استخدام منتج عشوائي من كلاس Product
          status: _randomStatus(),
          description: _randomDescription(),
        ),
      );
    }

    return notifications;
  }

  String _randomStatus() {
    List<String> statuses = ['Confirmed', 'Shipped', 'Cancelled'];
    return statuses[Random().nextInt(statuses.length)];
  }

  String _randomDescription() {
    List<String> descriptions = [
      'Your order has been confirmed.',
      'Your order has been shipped.',
      'Your order has been cancelled.'
    ];
    return descriptions[Random().nextInt(descriptions.length)];
  }
}

class NotificationItem {
  final Product product;
  final String status;
  final String description;

  NotificationItem({
    required this.product,
    required this.status,
    required this.description,
  });
}