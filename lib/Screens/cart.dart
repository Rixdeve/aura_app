import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> cartItems = [
    {
      "image":
          "https://www.hlgross.com/cdn/shop/files/m126233-0035_drp-upright-bba-with-shadow.png?v=1720528979",
      "name": "Rolex Cosmograph",
      "price": 400000,
      "quantity": 1, // Default quantity
    },
    {
      "image":
          "https://citizenwatch.widen.net/content/c155b5cxmk/webp/TSUYOSA.webp?u=41zuoe&width=800&height=800&quality=80&crop=false&keep=c&color=F9F8F6",
      "name": "Citizen Tsuyosa",
      "price": 40000,
      "quantity": 1, // Default quantity
    },
  ];

  int calculateTotal() {
    int total = 0;
    for (var item in cartItems) {
      total += (item["price"] as int) * (item["quantity"] as int);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        title: const Text(
          "Cart",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: isDarkMode
                        ? []
                        : [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 5,
                              spreadRadius: 1,
                              offset: const Offset(0, 2),
                            ),
                          ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        child: Image.network(
                          cartItems[index]["image"],
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cartItems[index]["name"],
                                style: theme.textTheme.bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 5),
                            Text(
                              "Rs. ${cartItems[index]["price"]}",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: theme.hintColor),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove_circle_outline,
                                color: theme.iconTheme.color),
                            onPressed: () {
                              setState(() {
                                if (cartItems[index]["quantity"] > 0) {
                                  cartItems[index]["quantity"]--;
                                }
                              });
                            },
                          ),
                          Text(
                            "${cartItems[index]["quantity"]}",
                            style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          IconButton(
                            icon: Icon(Icons.add_circle_outline,
                                color: theme.iconTheme.color),
                            onPressed: () {
                              setState(() {
                                cartItems[index]["quantity"]++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.cardColor,
              border: Border(
                top: BorderSide(color: theme.dividerColor, width: 1),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total:",
                        style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    Text(
                      "Rs. ${calculateTotal()}",
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text("Checkout",
                        style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onPrimary, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
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
              icon: Icon(Icons.home, color: Colors.black), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag, color: Colors.deepPurple),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.black), label: ''),
        ],
      ),
    );
  }
}
