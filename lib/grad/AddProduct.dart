import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(MaterialApp(
    home: AddProductScreen(),
  ));
}

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  List<XFile> _productImages = [];

  // Mock data for category and subcategory
  List<String> categories = [
    "Fashion",
    "Electronics",
    "Beauty",
    "Home & Garden",
    "Sports",
  ];

  Map<String, List<String>> subcategories = {
    "Fashion": ["Men's Clothing", "Women's Clothing", "Accessories"],
    "Electronics": ["Smartphones", "Laptops", "Headphones"],
    "Beauty": ["Skincare", "Makeup", "Fragrances"],
    "Home & Garden": ["Furniture", "Kitchenware", "Gardening"],
    "Sports": ["Fitness Equipment", "Sportswear", "Outdoor Gear"],
  };

  String selectedCategory = "";
  String selectedSubcategory = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        backgroundColor: const Color(0xFF684399),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                _uploadProductImages(context);
              },
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: const Color(0xFF684399).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Center(
                  child: Text(
                    'Upload Product Image',
                    style: TextStyle(
                      color: Color(0xFF684399),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildUploadedImages(),
            const SizedBox(height: 20),
            const Text(
              'Product Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Product Title'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'Product Description'),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            const Text(
              'Stock',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'Available Quantity'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            buildDropdown("Category", categories, (value) {
              setState(() {
                selectedCategory = value ?? "";
                selectedSubcategory =
                    ""; // Reset subcategory when category changes
              });
            }),
            const SizedBox(height: 10),
            buildDropdown("Subcategory", subcategories[selectedCategory] ?? [],
                (value) {
              setState(() {
                selectedSubcategory = value ?? "";
              });
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement functionality to save the product
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF684399),
              ),
              child: const Text('Save Product',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _uploadProductImages(BuildContext context) async {
    final pickedImages = await ImagePicker().pickMultiImage();
    if (pickedImages != null && pickedImages.isNotEmpty) {
      setState(() {
        _productImages = pickedImages;
      });
    }
  }

  Widget _buildUploadedImages() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: _productImages.map((image) {
        return Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.file(
              File(image.path),
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildDropdown(
      String labelText, List<String> items, void Function(String?)? onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownButtonFormField<String>(
        value: items.isEmpty ? null : items.first,
        onChanged: onChanged,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 5),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
