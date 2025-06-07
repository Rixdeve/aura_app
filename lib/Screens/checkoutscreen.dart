import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/auth_provider.dart';
import '../db/order_db.dart';
import '../models/cart_item.dart';
import '../db/cart_db.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController addressController = TextEditingController();
  String? location;

  Future<void> _getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    final position = await Geolocator.getCurrentPosition();
    setState(() {
      location = "${position.latitude}, ${position.longitude}";
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final cart = Provider.of<CartProvider>(context);

    final user = auth.user;

    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("Name: ${user?['name']}"),
            Text("Email: ${user?['email']}"),
            Text("Phone: ${user?['phone']}"),
            const SizedBox(height: 16),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: "Delivery Address",
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _getLocation,
              icon: const Icon(Icons.location_on),
              label: const Text("Get Current Location"),
            ),
            if (location != null) Text("Location: $location"),
            const SizedBox(height: 16),
            const Text("Cart Items:", style: TextStyle(fontSize: 16)),
            ...cart.items.map((item) => ListTile(
                  title: Text(item.name),
                  subtitle: Text("Rs. ${item.price} x ${item.quantity}"),
                )),
            const SizedBox(height: 16),
            Text("Total: Rs. ${cart.total}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                if (addressController.text.isEmpty || location == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Please provide address and location")),
                  );
                  return;
                }

                await OrderDatabase.instance.insertOrder(
                  userId: user?['id'],
                  name: user?['name'],
                  email: user?['email'],
                  phone: user?['phone'],
                  address: addressController.text,
                  location: location ?? '',
                  total: cart.total,
                  items: cart.items,
                );

                await cart.clearCart();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Order placed!")),
                );
                Navigator.pop(context);
              },
              child: const Text("Place Order"),
            ),
          ],
        ),
      ),
    );
  }
}
