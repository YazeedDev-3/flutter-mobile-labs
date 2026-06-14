import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final Map<String, dynamic> landmark;

  const DetailsPage({super.key, required this.landmark});

  @override
  Widget build(BuildContext context) {
    final name = landmark['name'] ?? 'التفاصيل';
    final imageUrl = landmark['image_url'] ?? '';
    final category = landmark['category'] ?? 'عام';
    final description =
        landmark['description'] ?? 'لا يوجد وصف متاح لهذا المعلم حالياً.';

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.green[800],
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 250,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,

                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(color: Colors.green[700]),
                  );
                },

                errorBuilder: (_, __, ___) => Container(
                  color: Colors.green[50],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.green[300],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "الرابط غير صالح أو لا يوجد إنترنت",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        "الرابط: $imageUrl",
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[900],
                              ),
                            ),
                          ),
                          Chip(
                            label: Text(category),
                            backgroundColor: Colors.green[50],
                            labelStyle: TextStyle(color: Colors.green[800]),
                            side: BorderSide(color: Colors.green[200]!),
                          ),
                        ],
                      ),

                      Divider(
                        height: 28,
                        color: Colors.green[200],
                        thickness: 1,
                      ),

                      Text(
                        "عن المعلم:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800],
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.7,
                          color: Colors.grey[800],
                        ),
                      ),

                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
