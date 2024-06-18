import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'product.dart';

class AddProductScreen extends StatefulWidget {
  final Product? product;

  const AddProductScreen({Key? key, this.product}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  List<XFile> _productImages = [];
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productDescriptionController = TextEditingController();
  TextEditingController _productPriceController = TextEditingController();
  TextEditingController _productStockController = TextEditingController();

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
  void initState() {
    super.initState();
    if (widget.product != null) {
      _productNameController.text = widget.product!.name;
      _productDescriptionController.text = widget.product!.description;
      _productPriceController.text = widget.product!.price.toString();
      _productStockController.text = widget.product!.stockStatus;
      selectedCategory = widget.product!.category;
      selectedSubcategory = widget.product!.subcategory;
      _productImages.add(XFile(widget.product!.imageFile.path));
    }
  }

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
                child: Center(
                  child: _productImages.isNotEmpty
                      ? Stack(
                    children: [
                      Image.file(
                        File(_productImages.first.path),
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              _productImages.clear();
                            });
                          },
                        ),
                      ),
                    ],
                  )
                      : const Text(
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
              controller: _productNameController,
              decoration: const InputDecoration(labelText: 'Product Title'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _productDescriptionController,
              decoration: const InputDecoration(labelText: 'Product Description'),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _productPriceController,
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
              controller: _productStockController,
              decoration: const InputDecoration(labelText: 'Available Quantity'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            buildDropdown("Category", categories, (value) {
              setState(() {
                selectedCategory = value ?? selectedCategory;
                selectedSubcategory = ""; // Reset subcategory when category changes
              });
            }),
            const SizedBox(height: 10),
            buildDropdown("Subcategory", subcategories[selectedCategory] ?? [], (value) {
              setState(() {
                selectedSubcategory = value ?? selectedSubcategory;
              });
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _canSaveProduct() ? _saveProduct : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _canSaveProduct() ? const Color(0xFF684399) : Colors.grey,
              ),
              child: const Text('Save Product', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _uploadProductImages(BuildContext context) async {
    final pickedImages = await ImagePicker().pickMultiImage();
    if (pickedImages.isNotEmpty) {
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

  Widget buildDropdown(String labelText, List<String> items, void Function(String?)? onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownButtonFormField<String>(
        value: items.contains(selectedCategory) ? selectedCategory : null,
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

  bool _canSaveProduct() {
    return _productNameController.text.isNotEmpty &&
        _productDescriptionController.text.isNotEmpty &&
        _productPriceController.text.isNotEmpty &&
        _productStockController.text.isNotEmpty &&
        selectedCategory.isNotEmpty &&
        selectedSubcategory.isNotEmpty &&
        _productImages.isNotEmpty;
  }

  void _saveProduct() {
    Navigator.pop(
      context,
      Product(
        name: _productNameController.text,
        description: _productDescriptionController.text,
        price: double.parse(_productPriceController.text),
        stockStatus: _productStockController.text,
        category: selectedCategory,
        subcategory: selectedSubcategory,
        imageFile: File(_productImages.first.path),
      ),
    );
  }
}
