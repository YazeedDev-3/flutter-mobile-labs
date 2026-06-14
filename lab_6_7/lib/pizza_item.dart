class PizzaItem {
  final String name;
  final int price;
  final String image;
  int quantity;

  PizzaItem({
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 0,
  });
}
