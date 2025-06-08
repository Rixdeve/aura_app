import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  void _launchPhone(String number) async {
    final Uri url = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void _launchEmail(String email) async {
    final Uri url = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("About Us")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            Center(
              child: Text(
                "Aura Luxury",
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Aura Luxury is a premier online shopping destination in Sri Lanka, offering a curated selection of high-end products. Our mission is to provide an exceptional shopping experience with a focus on quality, luxury, and customer satisfaction. We believe in bringing the best of global luxury brands to your doorstep.",
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 30),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text("Phone"),
              subtitle: const Text("+94 77 123 4567"),
              onTap: () => _launchPhone("+94771234567"),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text("Email"),
              subtitle: const Text("support@aura.lk"),
              onTap: () => _launchEmail("support@aura.lk"),
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text("Address"),
              subtitle: const Text("41, Highlevel Plaza, Nugegoda, Sri Lanka"),
            ),
          ],
        ),
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
            case 3:
              Navigator.pushNamed(context, '/about');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag, color: Colors.black),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info, color: Colors.deepPurple),
            label: '',
          ),
        ],
      ),
    );
  }
}
