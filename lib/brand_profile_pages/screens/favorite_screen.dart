import 'package:flutter/material.dart';
import '../models/products.dart';

class FavoritePage extends StatefulWidget {
  static List<Product> favoriteProducts = [];

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  void removeFromFavorites(Product product) {
    setState(() {
      FavoritePage.favoriteProducts.remove(product);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.title} has been removed from favorites'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Favorite Products'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: (){
            //Navigator.of(context).pop();
            },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 1.0, 6.0, 0.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: FavoritePage.favoriteProducts.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.asset(
                      FavoritePage.favoriteProducts[index].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                    child: Text(
                      FavoritePage.favoriteProducts[index].title,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${FavoritePage.favoriteProducts[index].price.toStringAsFixed(2)}',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        IconButton(
                          onPressed: () {
                            removeFromFavorites(FavoritePage.favoriteProducts[index]);
                          },
                          icon: Icon(Icons.delete),
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}