import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../db/user_db.dart';
import '../db/order_db.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Map<String, dynamic>> orders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    final user = Provider.of<AuthProvider>(context, listen: false).user;
    if (user == null) return;

    final db = await OrderDatabase.instance.database;

    // Query to join orders with their items
    final result = await db.rawQuery('''
    SELECT o.order_id, o.total, o.address, GROUP_CONCAT(oi.name, ', ') AS products
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.user_id = ?
    GROUP BY o.order_id
    ORDER BY o.order_id DESC
  ''', [user['id']]);

    setState(() {
      orders = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = Provider.of<AuthProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {},
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                        Text(user?['name'] ?? '',
                            style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 5),
                        Text(user?['email'] ?? '',
                            style: theme.textTheme.bodyMedium),
                        const SizedBox(height: 5),
                        Text(user?['phone'] ?? '',
                            style: theme.textTheme.bodyMedium),
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
                        style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 16),
                        height: 110,
                        child: Card(
                          color: theme.cardColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                const Icon(Icons.watch, size: 28),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          'Order ID: ${order['order_id'].toString()}',
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16)),
                                      Text(order['products'] ?? '',
                                          style: theme.textTheme.bodyMedium),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('Rs. ${order['total']}',
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                    const SizedBox(height: 4),
                                    GestureDetector(
                                      onTap: () => Navigator.pushNamed(
                                          context, '/report',
                                          arguments: order['order_id']),
                                      child: Text(
                                        "Report",
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
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
