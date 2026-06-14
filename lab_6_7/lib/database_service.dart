import 'package:mysql_client/mysql_client.dart';

class DatabaseService {
  final String host = '10.0.2.2';
  final int port = 3306;
  final String userName = 'root';
  final String password = '';
  final String databaseName = 'pizza_db';

  Future<MySQLConnection> getConnection() async {
    final conn = await MySQLConnection.createConnection(
      host: host,
      port: port,
      userName: userName,
      password: password,
      databaseName: databaseName,
    );
    await conn.connect();
    return conn;
  }

  Future<int> insertOrder(String customerName, int totalAmount) async {
    final conn = await getConnection();
    try {
      var result = await conn.execute(
        "INSERT INTO orders (custname, total, order_date) VALUES (:name, :total, NOW())",
        {"name": customerName, "total": totalAmount},
      );
      return result.lastInsertID.toInt();
    } catch (e) {
      print("insertOrder error: $e");
      rethrow;
    } finally {
      await conn.close();
    }
  }

  Future<void> insertPurchase(String itemName, int price, int quantity) async {
    final conn = await getConnection();
    try {
      await conn.execute(
        "INSERT INTO purchases (name, price, quantity) VALUES (:name, :price, :qty)",
        {"name": itemName, "price": price, "qty": quantity},
      );
    } catch (e) {
      print("insertPurchase error: $e");
      rethrow;
    } finally {
      await conn.close();
    }
  }
}
