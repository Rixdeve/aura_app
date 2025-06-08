import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:aura_app/models/productobj.dart';
import 'package:aura_app/models/transition.dart';
import 'package:aura_app/Screens/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products = [];
  bool isLoading = true;
  String selectedValue = 'Value';

  List<String> categories = [
    'Value',
    'Perfume',
    'Watch',
  ];

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

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse(
        'https://aura-luxury-master-e3rrhu.laravel.cloud/api/products'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final fetchedProducts =
          data.map((item) => Product.fromJson(item)).toList();

      final uniqueCategories = {'All'};
      for (var product in fetchedProducts) {
        if (product.category.isNotEmpty) {
          uniqueCategories.add(product.category);
        }
      }

      setState(() {
        products = fetchedProducts;
        categories = uniqueCategories.toList();
        selectedValue = 'All';
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    List<Product> displayedProducts = selectedValue == 'All'
        ? products
        : products.where((p) => p.category == selectedValue).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.network(
          'https://drive.google.com/uc?export=view&id=1BTlJm1oIIsgK-w5tOC1BG3Gg8hvG4UN_',
          height: 65,
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                      items: categories.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
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
                  const SizedBox(height: 20),
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
                      itemCount: displayedProducts.length,
                      itemBuilder: (context, index) {
                        final product = displayedProducts[index];

                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                print("product: ${product.id}");

                                Navigator.of(context).push(
                                  FadePageRoute(
                                      page: ProductDetailScreen(
                                          productId: product.id)),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  'https://storage.googleapis.com/aura_images/${product.imageUrl}',
                                  height: isLandscape ? 140 : 120,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image,
                                          color: Colors.grey),
                                ),
                              ),
                            ),
                            Text(
                              product.brand.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              product.productName,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                            Text(
                              'Rs. ${product.price.toStringAsFixed(0)}',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
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
            case 3:
              Navigator.pushNamed(context, '/about');
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
          BottomNavigationBarItem(
            icon: Icon(Icons.info, color: Colors.black),
            label: '',
          ),
        ],
      ),
    );
  }
}
