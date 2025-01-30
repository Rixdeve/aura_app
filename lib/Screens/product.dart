import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Image.asset(
          'assets/images/logo-remove.png', // Ensure correct path in pubspec.yaml
          height: 40,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),

            // ✅ Product Image
            Image.asset(
              'assets/images/rolex_watch.png', // Ensure correct path
              height: 200,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 10),

            // ✅ Product Name & Model
            const Text(
              'Rolex',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Cosmograph',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),

            const SizedBox(height: 10),

            // ✅ Buy Now Button
            ElevatedButton(
              onPressed: () {
                // Add functionality here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 5),
                minimumSize: const Size(double.infinity, 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child:
                  const Text('BUY NOW', style: TextStyle(color: Colors.white)),
            ),

            const SizedBox(height: 10),

            // ✅ Product Price
            const Text(
              'Rs. 400000',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // ✅ Specification Title
            const Text(
              'FULL SPECIFICATION',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // ✅ Specifications Table
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                },
                children: [
                  _buildTableRow('Bezel', 'Brand',
                      'Bi-directional Rotating Bezel', 'Rolex'),
                  _buildTableRow('Case Shape', 'Gender', 'Round', 'Male'),
                  _buildTableRow('Water Resistance', 'Warranty Period', '200 M',
                      '5 Years'),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          ],
        ),
      ),
    );
  }

  // ✅ Table Row Helper Function
  TableRow _buildTableRow(String leftTitle, String rightTitle, String leftValue,
      String rightValue) {
    return TableRow(
      children: [
        _buildTableCell(leftTitle),
        _buildTableCell(rightTitle),
        _buildTableCell(leftValue),
        _buildTableCell(rightValue),
      ],
    );
  }

  // ✅ Table Cell Helper Function
  Widget _buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
