import 'package:flutter/material.dart';
import 'database_service.dart';
import 'pizza_item.dart';

void main() => runApp(
  MaterialApp(debugShowCheckedModeBanner: false, home: PizzaShopHome()),
);

class PizzaShopHome extends StatefulWidget {
  @override
  _PizzaShopHomeState createState() => _PizzaShopHomeState();
}

class _PizzaShopHomeState extends State<PizzaShopHome> {
  final DatabaseService _dbService = DatabaseService();

  List<PizzaItem> items = [
    PizzaItem(name: "Margherita", price: 35, image: "assets/p1.jpeg"),
    PizzaItem(name: "Pepperoni", price: 35, image: "assets/p2.jpeg"),
    PizzaItem(name: "Garlic Twist", price: 25, image: "assets/s1.jpeg"),
    PizzaItem(name: "Water", price: 2, image: "assets/w1.jpeg"),
  ];

  int calculateTotal() {
    return items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  void handleBuy() async {
    int total = calculateTotal();
    if (total == 0) return;

    try {
      await _dbService.insertOrder("Yaz Customer", total);
      for (var item in items) {
        if (item.quantity > 0) {
          await _dbService.insertPurchase(item.name, item.price, item.quantity);
        }
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Total Price"),
          content: Text("Your total is $total SR"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Pizza Shop",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
        elevation: 2,
      ),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // Banner image
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Image.asset('assets/yaz_piz.jpeg', fit: BoxFit.cover),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              "Choose Your Order",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),

          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            items[index].image,
                            height: 85,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          items[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "${items[index].price} SR",
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Qty: ${items[index].quantity}",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline,
                                  color: Colors.deepOrange),
                              onPressed: () => setState(() {
                                if (items[index].quantity > 0)
                                  items[index].quantity--;
                              }),
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline,
                                  color: Colors.deepOrange),
                              onPressed: () =>
                                  setState(() => items[index].quantity++),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Total + Buy button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total: ${calculateTotal()} SR",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: handleBuy,
                  child: Text("Buy", style: TextStyle(fontSize: 15)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
