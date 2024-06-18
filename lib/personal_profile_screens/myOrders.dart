import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'detailedOrder.dart'; // Ensure to import the detailed order screen

class MyOrdersPage extends StatelessWidget {
  final List<Map<String, dynamic>> orders = List.generate(6, (index) {
    return {
      'orderNumber': 'Order #1234${index + 1}',
      'orderStatus': ['Placed', 'Confirmed', 'Shipped', 'Delivered'][index % 4],
      'items': List.generate(
          index + 1,
          (itemIndex) => {
                'productName': 'Product ${index * 2 + itemIndex + 1}',
                'productImage': 'images/image-not-found.jpg',
                'productPrice': '\$${100 + itemIndex * 50}',
              }),
      'price': 'EGP ${(index + 1) * 100}',
    };
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Row(
          children: [
            Text(
              'My Orders',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => detailedOrder(order: order),
                ),
              );
            },
            child: OrderCard(
              orderNumber: order['orderNumber'],
              orderStatus: order['orderStatus'],
              items: '${order['items'].length} items',
              price: order['price'],
            ),
          );
        },
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String orderNumber;
  final String orderStatus;
  final String items;
  final String price;

  const OrderCard({
    Key? key,
    required this.orderNumber,
    required this.orderStatus,
    required this.items,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      color: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: const BorderSide(color: Colors.grey, width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              orderNumber,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Items:',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
                Text(
                  items,
                  style: const TextStyle(fontSize: 14.0),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Order Status:',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
                Text(
                  orderStatus,
                  style: const TextStyle(fontSize: 14.0),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Price:',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
                Text(
                  price,
                  style: const TextStyle(fontSize: 14.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
