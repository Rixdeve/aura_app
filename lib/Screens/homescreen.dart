import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> brandLogos = List.filled(
    10,
    "https://www.hlgross.com/cdn/shop/files/m126233-0035_drp-upright-bba-with-shadow.png?v=1720528979",
  );

  final List<Map<String, dynamic>> products = [
    {
      "image":
          "https://www.hlgross.com/cdn/shop/files/m126233-0035_drp-upright-bba-with-shadow.png?v=1720528979",
      "name": "Rolex",
      "model": "Cosmograph",
      "price": "Rs. 400000",
    },
    {
      "image":
          "https://cdn2.jomashop.com/media/catalog/product/cache/fc2ff48f80400416c47c36b80c0a3202/s/e/seiko-seiko-5-automatic-white-dial-mens-watch-snkd97j1_1.jpg?width=546&height=546",
      "name": "Seiko",
      "model": "SNKDY082",
      "price": "Rs. 350000",
    },
    {
      "image":
          "https://citizenwatch.widen.net/content/c155b5cxmk/webp/TSUYOSA.webp?u=41zuoe&width=800&height=800&quality=80&crop=false&keep=c&color=F9F8F6",
      "name": "Citizen",
      "model": "Tsuyosa",
      "price": "Rs. 250000",
    },
    {
      "image": "https://blink.lk/wp-content/uploads/2024/07/G1050.png",
      "name": "Casio",
      "model": "G-Shock",
      "price": "Rs. 50000",
    },
  ];

  String selectedValue = 'Value'; // Default selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.network(
          'https://drive.google.com/uc?export=view&id=1BTlJm1oIIsgK-w5tOC1BG3Gg8hvG4UN_',
          height: 65,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.error,
            color: Colors.red,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ✅ Top Image Banner
            Image.network(
              "https://drive.google.com/uc?export=view&id=1S8Y3gk4DpVbDBQITX4jC5qdNGt-rvg33",
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error, color: Colors.red),
            ),
            const SizedBox(height: 10),

            // ✅ Sorting Dropdown
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: DropdownButton<String>(
                value: selectedValue,
                isExpanded: true,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
                items: <String>['Value', 'Price', 'Popularity']
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ),
                    )
                    .toList(),
              ),
            ),

            const SizedBox(height: 10),

            // ✅ Brand Logos Grid View
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: brandLogos.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: Image.network(
                      brandLogos[index],
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, color: Colors.red),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            TextButton(
              onPressed: () {},
              child: const Text(
                "VIEW ALL",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.7,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Image.network(
                        products[index]["image"],
                        height: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error, color: Colors.red),
                      ),
                      Text(
                        products[index]["name"],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        products[index]["model"],
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        products[index]["price"],
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Ensures fixed layout
        currentIndex: 0, // Set active tab (update dynamically if needed)
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/'); // Home
              break;
            case 1:
              Navigator.pushNamed(context, '/cart'); // Cart Page
              break;
            case 2:
              Navigator.pushNamed(context, '/profile'); // Profile Page
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.deepPurple,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_bag_rounded,
              color: Colors.black,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
