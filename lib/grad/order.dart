import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:start_project/chat_screens/chats_screen.dart';
import 'package:start_project/grad/product.dart';
import 'brandDetailedOrder.dart';
import 'brandProfile-brandView.dart';
import 'dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Orders Page',
      theme: ThemeData(
        primaryColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      home: OrdersPage(),
    );
  }
}

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final List<Order> orders = List.generate(
    20,
    (index) => Order(
      id: '#${7676 + index}',
      date: '06/30/2022',
      total: 700,
      completed: false,
    ),
  );

  List<Order> filteredOrders = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredOrders = orders;
  }

  void _filterOrders(String query) {
    setState(() {
      searchQuery = query;
      filteredOrders = orders
          .where(
              (order) => order.id.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Orders',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF684399),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                onChanged: _filterOrders,
                decoration: const InputDecoration(
                  hintText: 'Search order ID',
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  border: InputBorder.none,
                ),
                style: const TextStyle(fontSize: 14, color: Color(0xFF684399)),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.grey, width: 1.0)),
            ),
            child: const Row(
              children: [
                SizedBox(width: 50, child: Text("Select")),
                Expanded(child: Text("Order ID", textAlign: TextAlign.center)),
                Expanded(child: Text("Date", textAlign: TextAlign.center)),
                Expanded(child: Text("Total", textAlign: TextAlign.center)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredOrders.length,
              itemBuilder: (context, index) {
                return OrderRow(order: filteredOrders[index]);
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
          currentIndex: 1,
          backgroundColor: Colors.white,
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()));
                break;
              case 1:
                // already in orders page
                break;
              case 2:
                // Uncomment and replace with the actual MessagesPage if you have one
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChatsScreen()));
                break;
              case 3:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProductPage()));
                break;
              case 4:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
                break;
            }
          },
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.dashboard),
              title: const Text("Dashboard"),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.receipt_long, color: Color(0xFF684399)),
              title: const Text("Orders",
                  style: TextStyle(color: Color(0xFF684399))),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.message),
              title: const Text("Messages"),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.inventory_2),
              title: const Text("Products"),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.account_circle, color: Colors.black),
              title:
                  const Text("Account", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}

class Order {
  final String id;
  final String date;
  final int total;
  bool completed;

  Order({
    required this.id,
    required this.date,
    required this.total,
    this.completed = false,
  });
}

class OrderRow extends StatefulWidget {
  final Order order;

  OrderRow({required this.order});

  @override
  _OrderRowState createState() => _OrderRowState();
}

class _OrderRowState extends State<OrderRow> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BrandOwnerOrderDetails(
              orderData: {
                'orderNumber': widget.order.id,
                'orderDate': widget.order.date,
                'orderTotal': widget.order.total,
              },
            ),
          ),
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 1.0)),
        ),
        child: Row(
          children: [
            Checkbox(
              value: widget.order.completed,
              onChanged: (bool? value) {
                setState(() {
                  widget.order.completed = value ?? false;
                });
              },
            ),
            Expanded(child: Text(widget.order.id, textAlign: TextAlign.center)),
            Expanded(
                child: Text(widget.order.date, textAlign: TextAlign.center)),
            Expanded(
              child: Text(
                widget.order.total.toString(),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
