import 'package:flutter/material.dart';
import 'package:aura_app/models/transition.dart';
import 'package:aura_app/Screens/product.dart';

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
  final List<String> brandLogos = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDs0ZEzCw4VfdjoOIno3Xzy3WNvK5V2kLIjA&s",
    "https://1000logos.net/wp-content/uploads/2018/10/Seiko-Logo.png",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgRg1N5jBK4v43SbAYk5Ny_3MNfNYXz2LLwA&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPWRuWNlugg0pYzu4RwgrCNYbxhH4ImXtJew&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYcyve5JV1rvtp-wLJ-sVUhfJ6TONSjF8v7w&s",
    "https://img.freepik.com/free-vector/perfume-shop-logo-template-beauty-business-branding-design-black-white-vector_53876-156447.jpg",
    "https://bcassetcdn.com/public/blog/wp-content/uploads/2021/10/22125209/adequate-fragrance-by-tamas-mihaly-dribbble.png",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQztVS8DaAo-HLrk34Uao-WM6H_4kcx42EdmQ&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSt_AXrI7ONv2QDdsGjG0buYi5Xxlq7joaBA&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2e_impr6ewrcfxUhqE5ZA3xnE7paS_5LyQw&s"
  ];

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
    {
      "image": "https://m.media-amazon.com/images/I/71ahg3sYRAL.jpg",
      "name": "Victoria's Secret",
      "model": "Bombshell",
      "price": "Rs. 200000",
    },
    {
      "image":
          "https://www.chanel.com/images/w_0.51,h_0.51,c_crop/q_auto:good,f_auto,fl_lossy,dpr_1.1/w_1920/n-5-eau-de-parfum-spray-3-4fl-oz--packshot-default-125530-9539148742686.jpg",
      "name": "Channel",
      "model": "COCO Medemoiselle",
      "price": "Rs. 50000",
    },
  ];

  String selectedValue = 'Value';

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.network(
          'https://drive.google.com/uc?export=view&id=1BTlJm1oIIsgK-w5tOC1BG3Gg8hvG4UN_',
          height: 65,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              "https://drive.google.com/uc?export=view&id=1S8Y3gk4DpVbDBQITX4jC5qdNGt-rvg33",
              height: isLandscape ? 180 : 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
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
                items: <String>['Value', 'Perfume', 'Watches']
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isLandscape ? 8 : 4,
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
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isLandscape ? 4 : 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.65,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            FadePageRoute(page: const ProductDetailScreen()),
                          );
                        },
                        child: Image.network(
                          products[index]["image"],
                          height: isLandscape ? 140 : 120,
                          fit: BoxFit.cover,
                        ),
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
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
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
            icon: Icon(Icons.home, color: Colors.deepPurple),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_rounded, color: Colors.black),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black),
            label: '',
          ),
        ],
      ),
    );
  }
}
