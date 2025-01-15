import 'package:fire_app/widgets/order_card.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DiscoverPage(),
    );
  }
}

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> coffeeNames = [
      'Espresso',
      'Cappuccino',
      'Latte',
      'Americano',
      'Mocha',
      'Macchiato',
      'Flat White',
      'Affogato',
      'Irish Coffee',
      'Turkish Coffee'
    ];

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search anything',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Categories Section
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 10,
                children: [
                  CategoryChip(label: 'Coffee', icon: Icons.code),
                  CategoryChip(label: 'Tea', icon: Icons.brush),
                  CategoryChip(label: 'Smoothie', icon: Icons.campaign),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Popular Classes Section
            const Text(
              'List of Popular Classes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 800,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: List.generate(coffeeNames.length, (index) {
                  return OrderCard(
                    title: coffeeNames[index],
                    teacher: 'Barista ${index + 1}',
                    featured: index % 2 == 0, // Example condition for featured
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const CategoryChip({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
    );
  }
}
