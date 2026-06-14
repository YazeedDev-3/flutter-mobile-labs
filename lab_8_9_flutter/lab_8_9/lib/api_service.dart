import 'dart:convert';
import 'package:http/http.dart' as http;
import 'book.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:5035/APIBook';

  static Future<List<Book>> getAllBooks() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Book.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  static Future<void> insertBook(Map<String, dynamic> book) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(book),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to insert book');
    }
  }
}
