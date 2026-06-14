import 'package:flutter/material.dart';
import 'database_service.dart';
import 'details_page.dart';

class LandmarksListPage extends StatefulWidget {
  @override
  State<LandmarksListPage> createState() => _LandmarksListPageState();
}

class _LandmarksListPageState extends State<LandmarksListPage> {
  final DatabaseService _dbService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("معالم المدينة المنورة"),
        backgroundColor: Colors.green[800],
        foregroundColor: Colors.white,
        elevation: 2,
      ),

      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _dbService.getLandmarks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.green[700]),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text("حدث خطأ: ${snapshot.error}"));
          }

          final landmarks = snapshot.data ?? [];

          if (landmarks.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_off, size: 60, color: Colors.green[200]),
                  const SizedBox(height: 12),
                  const Text(
                    "لا توجد معالم مضافة بعد",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: landmarks.length,
            itemBuilder: (context, index) {
              final item = landmarks[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                elevation: 4,
                shadowColor: Colors.green.withOpacity(0.15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      item['image_url'] ?? '',
                      width: 65,
                      height: 65,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 65,
                        height: 65,
                        color: Colors.green[50],
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.green[300],
                        ),
                      ),
                    ),
                  ),

                  title: Text(
                    item['name'] ?? 'بدون اسم',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.green[900],
                    ),
                  ),

                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      item['category'] ?? 'عام',
                      style: TextStyle(color: Colors.green[700], fontSize: 13),
                    ),
                  ),

                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.green[700],
                  ),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailsPage(landmark: item),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/insert');
        },
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        tooltip: 'إضافة معلم',
        child: const Icon(Icons.add),
      ),
    );
  }
}
