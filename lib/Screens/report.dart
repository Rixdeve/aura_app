import 'package:flutter/material.dart';

class ReportProductScreen extends StatelessWidget {
  const ReportProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        title: const Text(
          "Report Product",
          style: TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // 🔙 Back Button
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📌 Order ID (Label instead of TextField)
            const Text(
              "Order ID: #001", // Replace with dynamic Order ID if needed
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            // 📌 Issue Description
            const Text(
              "Issue Description",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Describe the issue",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // 📌 Attach Image (Optional)
            const Text(
              "Attach Image (Optional)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                GestureDetector(
                  onTap: () {}, // No function, just UI
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey,
                    child: const Icon(Icons.camera_alt,
                        color: Colors.white, size: 30),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 📌 Submit Button

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {}, // No function, just UI
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  "Submit Report",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Ensures fixed layout
        currentIndex: 0, // Set active tab (update dynamically if needed)
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/product'); // Home
              break;
            case 1:
              Navigator.pushNamed(context, '/cart'); // Product Page
              break;
            case 2:
              Navigator.pushNamed(context, '/profile'); // Login Page
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_bag,
                color: Colors.black,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.deepPurple,
              ),
              label: ''),
        ],
      ),
    );
  }
}
