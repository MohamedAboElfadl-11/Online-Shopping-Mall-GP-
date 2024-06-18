import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../constants.dart';
import '../models/cart_item.dart';
import '../widgets/cart_tile.dart';
import '../widgets/check_out_box.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void removeItem(CartItem item) {
    setState(() {
      cartItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcontentColor,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "My Cart",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: IconButton(
            onPressed: () {
             //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
            },
            icon: const Icon(
              Ionicons.arrow_back_outline,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),

      ),
      bottomSheet: cartItems.isNotEmpty ? CheckOutBox(items: cartItems) : null,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            if (cartItems.isEmpty)
              Center(
                child: Text(
                  "Your cart is empty",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            for (var item in cartItems) ...[
              CartTile(
                item: item,
                onRemove: () {
                  if (item.quantity != 1) {
                    setState(() {
                      item.quantity--;
                    });
                  }
                },
                onAdd: () {
                  setState(() {
                    item.quantity++;
                  });
                },
                onRemoveItem: () {
                  removeItem(item);
                },
              ),
              const SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }
}