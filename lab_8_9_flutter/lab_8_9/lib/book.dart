class Book {
  final int id;
  final String bookName;
  final String category;
  final double price;

  Book({
    required this.id,
    required this.bookName,
    required this.category,
    required this.price,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      bookName: json['bookName'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] as num).toDouble(),
    );
  }
}
