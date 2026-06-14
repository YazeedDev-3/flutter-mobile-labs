import 'package:mysql_client/mysql_client.dart';

class DatabaseService {
  final String host = '10.0.2.2';
  final int port = 3306;
  final String userName = 'root';
  final String password = '';
  final String databaseName = 'landmarks_db';

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

  Future<List<Map<String, dynamic>>> getLandmarks() async {
    final conn = await getConnection();
    var result = await conn.execute("SELECT * FROM landmarks");
    List<Map<String, dynamic>> list = [];
    for (var row in result.rows) {
      list.add(row.assoc());
    }
    await conn.close();
    return list;
  }

  Future<void> insertLandmark(
    String name,
    String cat,
    String desc,
    String img,
  ) async {
    final conn = await getConnection();
    await conn.execute(
      "INSERT INTO landmarks (name, category, description, image_url) VALUES (:name, :cat, :desc, :img)",
      {"name": name, "cat": cat, "desc": desc, "img": img},
    );
    await conn.close();
  }
}
