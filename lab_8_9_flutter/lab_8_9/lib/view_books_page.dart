import 'package:flutter/material.dart';
import 'api_service.dart';
import 'book.dart';

class ViewBooksPage extends StatefulWidget {
  @override
  _ViewBooksPageState createState() => _ViewBooksPageState();
}

class _ViewBooksPageState extends State<ViewBooksPage> {
  List<Book> books = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    try {
      final fetchedBooks = await ApiService.getAllBooks();
      setState(() {
        books = fetchedBooks;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load books. Please try again.';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Books')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : books.isEmpty
                  ? Center(child: Text('No books found'))
                  : ListView.builder(
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        final book = books[index];
                        return ListTile(
                          title: Text(book.bookName),
                          subtitle: Text(book.category),
                          trailing: Text('\$${book.price}'),
                        );
                      },
                    ),
    );
  }
}
