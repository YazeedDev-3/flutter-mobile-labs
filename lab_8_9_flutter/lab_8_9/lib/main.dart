import 'package:flutter/material.dart';
import 'insert_book_page.dart';
import 'view_books_page.dart';

void main() {
  runApp(BookstoreApp());
}

class BookstoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bookstore App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/insertBook': (context) => InsertBookPage(),
        '/viewBooks': (context) => ViewBooksPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bookstore')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/insertBook');
              },
              child: Text('Insert Book'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/viewBooks');
              },
              child: Text('View All Books'),
            ),
          ],
        ),
      ),
    );
  }
}
