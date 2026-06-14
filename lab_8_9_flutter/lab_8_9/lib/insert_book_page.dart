import 'package:flutter/material.dart';
import 'api_service.dart';

class InsertBookPage extends StatefulWidget {
  @override
  _InsertBookPageState createState() => _InsertBookPageState();
}

class _InsertBookPageState extends State<InsertBookPage> {
  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  void dispose() {
    bookNameController.dispose();
    categoryController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Insert Book')),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: bookNameController,
              decoration: InputDecoration(
                labelText: 'Book Name',
                hintText: 'Enter book name',
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: categoryController,
              decoration: InputDecoration(
                labelText: 'Category',
                hintText: 'Enter category',
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                labelText: 'Price',
                hintText: 'Enter price',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (bookNameController.text.isEmpty ||
                      categoryController.text.isEmpty ||
                      priceController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill in all fields')),
                    );
                    return;
                  }

                  double price;
                  try {
                    price = double.parse(priceController.text);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter a valid price')),
                    );
                    return;
                  }

                  try {
                    await ApiService.insertBook({
                      'bookName': bookNameController.text,
                      'category': categoryController.text,
                      'price': price,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Book inserted successfully')),
                    );
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to insert book')),
                    );
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('Insert Book', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
