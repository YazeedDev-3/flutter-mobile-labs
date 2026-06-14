import 'package:flutter/material.dart';
import 'database_service.dart';
import 'landmarks_list_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      home: LandmarksListPage(),
      routes: {'/insert': (context) => InsertLandmarkPage()},
    ),
  );
}

class InsertLandmarkPage extends StatefulWidget {
  @override
  State<InsertLandmarkPage> createState() => _InsertLandmarkPageState();
}

class _InsertLandmarkPageState extends State<InsertLandmarkPage> {
  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final descController = TextEditingController();
  final imageController = TextEditingController();

  final DatabaseService _dbService = DatabaseService();

  @override
  void dispose() {
    nameController.dispose();
    categoryController.dispose();
    descController.dispose();
    imageController.dispose();
    super.dispose();
  }

  void _saveData() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: CircularProgressIndicator(color: Colors.green[700]),
      ),
    );

    try {
      await _dbService.insertLandmark(
        nameController.text.trim(),
        categoryController.text.trim(),
        descController.text.trim(),
        imageController.text.trim(),
      );

      Navigator.pop(context);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("تمت إضافة المعلم بنجاح! ✅")));

      nameController.clear();
      categoryController.clear();
      descController.clear();
      imageController.clear();
    } catch (e) {
      Navigator.pop(context);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("حدث خطأ: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("إضافة معلم سياحي"),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildTextField(
                    nameController,
                    "اسم المعلم (مثلاً: مسجد قباء)",
                  ),
                  _buildTextField(
                    categoryController,
                    "التصنيف (تاريخي، ترفيهي...)",
                  ),
                  _buildTextField(
                    descController,
                    "الوصف التفصيلي",
                    maxLines: 3,
                  ),
                  _buildTextField(imageController, "رابط الصورة (URL)"),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _saveData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: Text(
                        "حفظ المعلم في القاعدة",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.green[700]),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.green[700]!, width: 2),
          ),
          filled: true,
          fillColor: Colors.grey[50],
        ),
      ),
    );
  }
}
