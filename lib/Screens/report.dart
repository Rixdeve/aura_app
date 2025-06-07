import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../models/report.dart';
import '../db/order_db.dart';

class ReportProductScreen extends StatefulWidget {
  final int orderId;
  const ReportProductScreen({super.key, required this.orderId});

  @override
  State<ReportProductScreen> createState() => _ReportProductScreenState();
}

class _ReportProductScreenState extends State<ReportProductScreen> {
  final TextEditingController _descController = TextEditingController();
  File? _imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.camera);

    if (picked != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = p.basename(picked.path);
      final savedImage =
          await File(picked.path).copy('${appDir.path}/$fileName');

      setState(() {
        _imageFile = savedImage;
      });
    }
  }

  void _submit() async {
    final report = Report(
      orderId: widget.orderId,
      description: _descController.text,
      imagePath: _imageFile?.path,
      createdAt: DateTime.now().toIso8601String(),
    );

    await OrderDatabase.instance.insertReport(report);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Report submitted successfully!")),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Report Product")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Order ID: #${widget.orderId}"),
            const SizedBox(height: 10),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(
                labelText: "Issue Description",
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 20),

            // Camera button and preview
            Row(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: theme.colorScheme.secondary,
                    child: const Icon(Icons.camera_alt, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _imageFile != null
                      ? Text("Image: ${p.basename(_imageFile!.path)}")
                      : const Text("Tap to take an image"),
                ),
              ],
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: const Text("Submit Report"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/product');
              break;
            case 1:
              Navigator.pushNamed(context, '/cart');
              break;
            case 2:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag, color: Colors.black), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.deepPurple), label: ''),
        ],
      ),
    );
  }
}
