import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    List<Map<String, String>> orders = [
      {
        "id": "#001",
        "product": "Rolex Cosmograph, Omega New",
        "date": "2 Jan, 2024",
        "price": "Rs. 400000",
        "status": "Pending"
      },
      {
        "id": "#002",
        "product": "Seiko SNKDY082",
        "date": "5 Jan, 2024",
        "price": "Rs. 350000",
        "status": "Dispatched"
      },
      {
        "id": "#003",
        "product": "Citizen Tsuyosa, Seiko SNKDY082",
        "date": "10 Jan, 2024",
        "price": "Rs. 250000",
        "status": "Accepted"
      },
      {
        "id": "#004",
        "product": "Casio G-Shok",
        "date": "15 Jan, 2024",
        "price": "Rs. 50000",
        "status": "Canceled"
      },
      {
        "id": "#006",
        "product": "Seiko Watch",
        "date": "20 Jan, 2024",
        "report": "Report",
        "price": "Rs. 222038",
        "status": "Delivered"
      },
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        title: Text(
          "Profile",
          style: theme.textTheme.titleLarge,
        ),
        iconTheme: IconThemeData(color: theme.iconTheme.color),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: theme.iconTheme.color),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Risinu Kaluarchchi",
                      style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 5),
                  Text("risinuh@email.com", style: theme.textTheme.bodyMedium),
                  const SizedBox(height: 5),
                  Text("+94 77 155 9994", style: theme.textTheme.bodyMedium),
                  const SizedBox(height: 5),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Order History",
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                  height: 110,
                  child: Card(
                    color: theme.cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: isDarkMode ? 0 : 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(Icons.watch,
                              size: 28, color: theme.iconTheme.color),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  orders[index]["product"]!,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  "${orders[index]["date"]} | ${orders[index]["id"]}",
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                orders[index]["price"]!,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              _buildStatusLabel(orders[index]["status"]!),
                              if (orders[index]["status"] == "Delivered")
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/report');
                                  },
                                  child: Text(
                                    "Report",
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
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

  Widget _buildStatusLabel(String status) {
    Color color;
    switch (status) {
      case "Pending":
        color = Colors.orange;
        break;
      case "Dispatched":
        color = Colors.blue;
        break;
      case "Accepted":
        color = Colors.green;
        break;
      case "Canceled":
        color = Colors.red;
        break;
      default:
        color = Colors.black;
    }

    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(status,
          style: TextStyle(
              color: color, fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }
}
